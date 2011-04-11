/*
 * Copyright (C) 2008-2011 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2006-2009 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

#include "ScriptPCH.h"
#include "dark_portal.h"
 
class instance_the_dark_portal : public InstanceMapScript
{
public:
    instance_the_dark_portal() : InstanceMapScript("instance_dark_portal", 269) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_the_dark_portal_InstanceMapScript(pMap);
    }

    struct  instance_the_dark_portal_InstanceMapScript : public InstanceScript
    {
        instance_the_dark_portal_InstanceMapScript(Map *Map) : InstanceScript(Map) {};
 
        uint64 Medivh;
        uint32 IsMedivhDead;
        uint32 IsChronoLordDejaDead;
        uint32 IsTemporusDead;
        uint32 IsAeonusDead;
        uint32 Wave;
        uint32 ShieldPercent;
 
        void Initialize()
        {
            Medivh = 0;
            IsMedivhDead = 0;
            IsChronoLordDejaDead = 0;
            IsTemporusDead = 0;
            IsAeonusDead = 0;
            Wave = 0;
            ShieldPercent = 100;
        }

        bool IsEncounterInProgress()
        {
            return ((Wave > 0) && (!IsAeonusDead));
        }

        void OnCreatureCreate(Creature* creature)
        {
            switch(creature->GetEntry())
            {
                case 15608:
                    Medivh = creature->GetGUID();
                    break;
            }
        }
 
        uint64 GetData64(uint32 identifier)
        {
            if (identifier == DATA_MEDIVH)
                return Medivh;
            return 0;
        }
 
        uint32 GetData(uint32 type)
        { 
            if(type == DATA_MEDIVHDEATH)
                return IsMedivhDead;
            if(type == DATA_CHRONOLORDDEJADEATH)
                return IsChronoLordDejaDead;
            if(type == DATA_TEMPORUSDEATH)
                return IsTemporusDead;
            if(type == DATA_AEONUSDEATH)
                return IsAeonusDead;
            if(type == DATA_WAVE)
                return Wave;
            if(type == DATA_SHIELDPERCENT)
                return ShieldPercent;
            return 0;
        }
 
        void SetData(uint32 type, uint32 data)
        {
            if(type == DATA_MEDIVHDEATH)
                IsMedivhDead = data;
            else if(type == DATA_CHRONOLORDDEJADEATH)
                IsChronoLordDejaDead = data;
            else if(type == DATA_TEMPORUSDEATH)
                IsTemporusDead = data;
            else if(type == DATA_AEONUSDEATH)
                IsAeonusDead = data;
            else if(type == DATA_WAVE)
                Wave = data;
            else if(type == DATA_SHIELDPERCENT)
                ShieldPercent = data;
        }

        std::string GetSaveData()
        {
            OUT_SAVE_INST_DATA;
            std::ostringstream stream;
            stream << IsChronoLordDejaDead << " " << IsTemporusDead << " " << IsAeonusDead;
            std::string data = stream.str();
            return data.c_str();
        }

        void Load(const char* in)
        {
            if(!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);
            std::istringstream stream(in);
            stream >> IsChronoLordDejaDead >> IsTemporusDead >> IsAeonusDead;
            OUT_LOAD_INST_DATA_COMPLETE;
        }

    };
};

void AddSC_instance_dark_portal()
{
    new instance_the_dark_portal();
}
