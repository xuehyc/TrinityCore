/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef APPENDERDB_H
#define APPENDERDB_H

#include "Appender.h"

class DATABASE_API AppenderDB: public Appender
{
    public:
        typedef std::integral_constant<AppenderType, APPENDER_DB>::type TypeIndex;

        AppenderDB(uint8 id, std::string const& name, LogLevel level, AppenderFlags flags, std::vector<char const*> extraArgs);
        ~AppenderDB();

        void setRealmId(uint32 realmId) override;
        AppenderType getType() const override { return TypeIndex::value; }

    private:
        uint32 realmId;
        bool enabled;
        void _write(LogMessage const* message) override;
};

#endif
