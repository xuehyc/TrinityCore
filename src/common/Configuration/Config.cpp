/*
 * This file is part of the WarheadCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "Config.h"
#include "Log.h"
#include "SystemLog.h"
#include "StringConvert.h"
#include "Util.h"
#include <boost/property_tree/ini_parser.hpp>
#include <algorithm>
#include <memory>
#include <mutex>

namespace bpt = boost::property_tree;

namespace
{
    std::string _filename;
    std::vector<std::string> _additonalFiles;
    std::vector<std::string> _args;
    bpt::ptree _config;
    std::mutex _configLock;

    bool LoadFile(std::string const& file, bpt::ptree& fullTree, std::string& error)
    {
        try
        {
            bpt::ini_parser::read_ini(file, fullTree);

            if (fullTree.empty())
            {
                error = "empty file (" + file + ")";
                return false;
            }
        }
        catch (bpt::ini_parser::ini_parser_error const& e)
        {
            if (e.line() == 0)
                error = e.message() + " (" + e.filename() + ")";
            else
                error = e.message() + " (" + e.filename() + ":" + std::to_string(e.line()) + ")";
            return false;
        }

        return true;
    }
}

bool ConfigMgr::LoadInitial(std::string const& file, std::string& error)
{
    std::lock_guard<std::mutex> lock(_configLock);

    bpt::ptree fullTree;
    if (!LoadFile(file, fullTree, error))
        return false;

    // Since we're using only one section per config file, we skip the section and have direct property access
    _config = fullTree.begin()->second;

    return true;
}

bool ConfigMgr::LoadAdditionalFile(std::string file, std::string& error)
{
    bpt::ptree fullTree;
    if (!LoadFile(file, fullTree, error))
        return false;

    for (bpt::ptree::value_type const& child : fullTree.begin()->second)
        _config.put_child(bpt::ptree::path_type(child.first, '/'), child.second);

    return true;
}

ConfigMgr* ConfigMgr::instance()
{
    static ConfigMgr instance;
    return &instance;
}

bool ConfigMgr::Reload()
{
    if (!LoadAppConfigs())
        return false;

    return LoadModulesConfigs();
}

template<class T>
T ConfigMgr::GetValueDefault(std::string const& name, T def, bool quiet) const
{
    try
    {
        return _config.get<T>(bpt::ptree::path_type(name, '/'));
    }
    catch (bpt::ptree_bad_path const&)
    {
        if (!quiet)
        {
            LOG_WARN("server.loading", "Missing name %s in config file %s, add \"%s = %s\" to this file",
                name.c_str(), _filename.c_str(), name.c_str(), std::to_string(def).c_str());
        }
    }
    catch (bpt::ptree_bad_data const&)
    {
        LOG_ERROR("server.loading", "Bad value defined for name %s in config file %s, going to use %s instead",
            name.c_str(), _filename.c_str(), std::to_string(def).c_str());
    }

    return def;
}

template<>
std::string ConfigMgr::GetValueDefault<std::string>(std::string const& name, std::string def, bool quiet) const
{
    try
    {
        return _config.get<std::string>(bpt::ptree::path_type(name, '/'));
    }
    catch (bpt::ptree_bad_path const&)
    {
        if (!quiet)
        {
            LOG_WARN("server.loading", "Missing name %s in config file %s, add \"%s = %s\" to this file",
                name.c_str(), _filename.c_str(), name.c_str(), def.c_str());
        }
    }
    catch (bpt::ptree_bad_data const&)
    {
        LOG_ERROR("server.loading", "Bad value defined for name %s in config file %s, going to use %s instead",
            name.c_str(), _filename.c_str(), def.c_str());
    }

    return def;
}

std::string ConfigMgr::GetStringDefault(std::string const& name, const std::string& def, bool quiet) const
{
    std::string val = GetValueDefault(name, def, quiet);
    val.erase(std::remove(val.begin(), val.end(), '"'), val.end());
    return val;
}

bool ConfigMgr::GetBoolDefault(std::string const& name, bool def, bool quiet) const
{
    std::string val = GetValueDefault(name, std::string(def ? "1" : "0"), quiet);
    val.erase(std::remove(val.begin(), val.end(), '"'), val.end());
    Optional<bool> boolVal = Warhead::StringTo<bool>(val);
    if (boolVal)
        return *boolVal;
    else
    {
        LOG_ERROR("server.loading", "Bad value defined for name %s in config file %s, going to use '%s' instead",
            name.c_str(), _filename.c_str(), def ? "true" : "false");
        return def;
    }
}

int ConfigMgr::GetIntDefault(std::string const& name, int def, bool quiet) const
{
    return GetValueDefault(name, def, quiet);
}

float ConfigMgr::GetFloatDefault(std::string const& name, float def, bool quiet) const
{
    return GetValueDefault(name, def, quiet);
}

std::string const& ConfigMgr::GetFilename()
{
    std::lock_guard<std::mutex> lock(_configLock);
    return _filename;
}

std::vector<std::string> const& ConfigMgr::GetArguments() const
{
    return _args;
}

std::vector<std::string> ConfigMgr::GetKeysByString(std::string const& name)
{
    std::lock_guard<std::mutex> lock(_configLock);

    std::vector<std::string> keys;

    for (bpt::ptree::value_type const& child : _config)
        if (child.first.compare(0, name.length(), name) == 0)
            keys.push_back(child.first);

    return keys;
}

std::string const ConfigMgr::GetConfigPath()
{
    std::lock_guard<std::mutex> lock(_configLock);

#if WARHEAD_PLATFORM == WARHEAD_PLATFORM_WINDOWS
    return "configs/";
#else
    return std::string(CONF_DIR) + "/";
#endif
}

void ConfigMgr::Configure(std::string const& initFileName, std::vector<std::string> args, std::string const& modulesConfigList /*= ""*/)
{
    _filename = initFileName;
    _args = std::move(args);

    if (!modulesConfigList.empty())
        for (auto const& itr : Warhead::Tokenize(modulesConfigList, ',', false))
            _additonalFiles.emplace_back(std::string(itr));
}

bool ConfigMgr::LoadAppConfigs()
{
    std::string configError;

    // #1 - Load init config file .conf.dist
    if (!LoadInitial(_filename + ".dist", configError))
    {
        SYS_LOG_ERROR("> Config: Error in config file: %s", configError.c_str());
        return false;
    }

    // #2 - Load .conf file
    if (!LoadAdditionalFile(_filename, configError))
    {
        SYS_LOG_ERROR("> Config: Error in config file: %s", configError.c_str());
        return false;
    }

    return true;
}

bool ConfigMgr::LoadModulesConfigs()
{
    if (_additonalFiles.empty())
        return false;

    // Start loading module configs
    std::vector<std::string /*config variant*/> moduleConfigFiles;
    std::string error;
    std::string const& moduleConfigPath = GetConfigPath() + "modules/";
    bool isExistDefaultConfig = true;
    bool isExistDistConfig = true;

    for (auto const& distFileName : _additonalFiles)
    {
        std::string defaultFileName = distFileName;

        if (!defaultFileName.empty())
            defaultFileName.erase(defaultFileName.end() - 5, defaultFileName.end());

        // Load .conf.dist config
        if (!LoadAdditionalFile(moduleConfigPath + distFileName, error))
        {
            LOG_ERROR("config", "> Config: Error at loading module config file. %s", error.c_str());
            isExistDistConfig = false;
        }

        // Load .conf config
        if (!LoadAdditionalFile(moduleConfigPath + defaultFileName, error))
        {
            LOG_ERROR("config", "> Config: Error at loading module config file. %s", error.c_str());
            isExistDefaultConfig = false;
        }

        if (isExistDefaultConfig && isExistDistConfig)
            moduleConfigFiles.emplace_back(defaultFileName);
        else if (!isExistDefaultConfig && isExistDistConfig)
            moduleConfigFiles.emplace_back(distFileName);
    }

    // If module configs not exist - no load
    if (moduleConfigFiles.empty())
        return false;

    // Print modules configurations
    LOG_INFO("config", "");
    LOG_INFO("config", "Using modules configuration:");

    for (auto const& itr : moduleConfigFiles)
        LOG_INFO("config", "> %s", itr.c_str());

    LOG_INFO("config", "");

    return true;
}
