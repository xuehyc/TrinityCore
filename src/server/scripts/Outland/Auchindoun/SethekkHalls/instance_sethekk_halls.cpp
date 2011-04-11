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

/* ScriptData
SDName: Instance - Sethekk Halls
SD%Complete: 50
SDComment: Instance Data for Sethekk Halls instance
SDCategory: Auchindoun, Sethekk Halls
EndScriptData */

#include "ScriptPCH.h"
#include "sethekk_halls.h"

enum eEnums
{
    NPC_ANZU   = 23035,
    IKISS_DOOR = 177203,
};

class instance_sethekk_halls : public InstanceMapScript
{
public:
    instance_sethekk_halls() : InstanceMapScript("instance_sethekk_halls", 556) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_sethekk_halls_InstanceMapScript(pMap);
    }

    struct instance_sethekk_halls_InstanceMapScript : public InstanceScript
    {
        instance_sethekk_halls_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

        uint32 AnzuEncounter;
        uint32 IkissEncounter;
        uint64 m_uiIkissDoorGUID;

        std::string str_data;

        void Initialize()
        {
            AnzuEncounter = NOT_STARTED;
            IkissEncounter = NOT_STARTED;
            m_uiIkissDoorGUID = 0;
        }

        void OnCreatureCreate(Creature* creature)
        {
            if (creature->GetEntry() == NPC_ANZU)
            {
                if (AnzuEncounter >= IN_PROGRESS)
                    creature->DisappearAndDie();
                else
                    AnzuEncounter = IN_PROGRESS;
            }
        }

        void OnGameObjectCreate(GameObject* go)
        {
             if (go->GetEntry() == IKISS_DOOR)
                m_uiIkissDoorGUID = go->GetGUID();
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case DATA_IKISSDOOREVENT:
                    if (data == DONE)
                        DoUseDoorOrButton(m_uiIkissDoorGUID,DAY*IN_MILLISECONDS);
                    if(IkissEncounter != DONE)
                        IkissEncounter = data;
                    break;
                case TYPE_ANZU_ENCOUNTER:
                    if(AnzuEncounter != DONE)
                        AnzuEncounter = data;
                    break;
            }

            if (data == DONE)
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "S H " << IkissEncounter << " " << AnzuEncounter;

                str_data = saveStream.str();

                SaveToDB();
                OUT_SAVE_INST_DATA_COMPLETE;
            }
        }

        std::string GetSaveData()
        {
            return str_data.c_str();
        }

        void Load(const char* in)
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            uint32 Temp_IkissEncounter;
            uint32 Temp_AnzuEncounter;
            char dataHead1, dataHead2;

            OUT_LOAD_INST_DATA(in);

            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2 >> Temp_IkissEncounter >> Temp_AnzuEncounter;

            if(dataHead1 == 'S' && dataHead2 == 'H')
            {
                IkissEncounter = Temp_IkissEncounter;
                AnzuEncounter = Temp_AnzuEncounter;
            }

            if(IkissEncounter == IN_PROGRESS)
                IkissEncounter = NOT_STARTED;

            if(AnzuEncounter == IN_PROGRESS)
                AnzuEncounter = NOT_STARTED;

            OUT_LOAD_INST_DATA_COMPLETE;
        }
    };
};
void AddSC_instance_sethekk_halls()
{
    new instance_sethekk_halls();
}

