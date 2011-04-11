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
SDName: Instance_Molten_Core
SD%Complete: 0
SDComment: Place Holder
SDCategory: Molten Core
EndScriptData */

#include "ScriptPCH.h"
#include "molten_core.h"

#define MAX_ENCOUNTER      10

enum MoltenCoreBosses
{
    ID_LUCIFRON = 12118,
    ID_MAGMADAR = 11982,
    ID_GEHENNAS = 12259,
    ID_GARR = 12057,
    ID_GEDDON = 12056,
    ID_SHAZZRAH = 12264,
    ID_GOLEMAGG = 11988,
    ID_SULFURON = 12098,
    ID_DOMO = 12018,
    ID_RAGNAROS = 11502,
    ID_FLAMEWAKERPRIEST = 11662
};

class instance_molten_core : public InstanceMapScript
{
public:
    instance_molten_core() : InstanceMapScript("instance_molten_core", 409) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_molten_core_InstanceMapScript (pMap);
    }

    struct instance_molten_core_InstanceMapScript : public InstanceScript
    {
        instance_molten_core_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {};

        uint64 Lucifron, Magmadar, Gehennas, Garr, Geddon, Shazzrah, Sulfuron, Golemagg, Domo, Ragnaros, FlamewakerPriest;
        uint64 RuneKoro, RuneZeth, RuneMazj, RuneTheri, RuneBlaz, RuneKress, RuneMohn, m_uiFirelordCacheGUID;

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        bool golemagisdead;
        uint32 ragnarossummoned;

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            Lucifron = 0;
            Magmadar = 0;
            Gehennas = 0;
            Garr = 0;
            Geddon = 0;
            Shazzrah = 0;
            Sulfuron = 0;
            Golemagg = 0;
            Domo = 0;
            Ragnaros = 0;
            FlamewakerPriest = 0;

            RuneKoro = 0;
            RuneZeth = 0;
            RuneMazj = 0;
            RuneTheri = 0;
            RuneBlaz = 0;
            RuneKress = 0;
            RuneMohn = 0;

            m_uiFirelordCacheGUID = 0;

            golemagisdead = false;
            ragnarossummoned = NOT_STARTED;
        }

        bool IsEncounterInProgress() const
        {
        for(uint8 i = 0; i < MAX_ENCOUNTER; i++)
            if(m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        };

        void OnGameObjectCreate(GameObject* pGo)
        {
            switch(pGo->GetEntry())
            {
            case 176951:                                    //Sulfuron
                RuneKoro = pGo->GetGUID();
                break;
            case 176952:                                    //Geddon
                RuneZeth = pGo->GetGUID();
                break;
            case 176953:                                    //Shazzrah
                RuneMazj = pGo->GetGUID();
                break;
            case 176954:                                    //Golemagg
                RuneTheri = pGo->GetGUID();
                break;
            case 176955:                                    //Garr
                RuneBlaz = pGo->GetGUID();
                break;
            case 176956:                                    //Magmadar
                RuneKress = pGo->GetGUID();
                break;
            case 176957:                                    //Gehennas
                RuneMohn = pGo->GetGUID();
                break;
            case 179703:
                m_uiFirelordCacheGUID = pGo->GetGUID();      //when majordomo event == DONE DoRespawnGameObject(m_uiFirelordCacheGUID,);
                break;
            }
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            switch (pCreature->GetEntry())
            {
            case ID_LUCIFRON: Lucifron = pCreature->GetGUID(); break;
            case ID_MAGMADAR: Magmadar = pCreature->GetGUID(); break;
            case ID_GEHENNAS: Gehennas = pCreature->GetGUID(); break;
            case ID_GARR: Garr = pCreature->GetGUID(); break;
            case ID_GEDDON: Geddon = pCreature->GetGUID(); break;
            case ID_SHAZZRAH: Shazzrah = pCreature->GetGUID(); break;
            case ID_SULFURON: Sulfuron = pCreature->GetGUID(); break;
            case ID_GOLEMAGG: Golemagg = pCreature->GetGUID(); break;
            case ID_DOMO: Domo = pCreature->GetGUID(); pCreature->setActive(true); break;
            case ID_RAGNAROS: Ragnaros = pCreature->GetGUID(); break;
            case ID_FLAMEWAKERPRIEST: FlamewakerPriest = pCreature->GetGUID(); break;
            }
        }

        uint64 GetData64 (uint32 identifier)
        {
            switch(identifier)
            {
                case DATA_SULFURON:
                    return Sulfuron;
                case DATA_GOLEMAGG:
                    return Golemagg;
                case DATA_FLAMEWAKERPRIEST:
                    return FlamewakerPriest;
                case DATA_MAJORDOMO:
                    return Domo;
            }
            return 0;
        }

        uint32 GetData(uint32 type)
        {
            switch(type)
            {
                case DATA_LUCIFRONISDEAD: return m_auiEncounter[0]; break;
                case DATA_MAGMADARISDEAD: return m_auiEncounter[1]; break;
                case DATA_GEHENNASISDEAD: return m_auiEncounter[2]; break;
                case DATA_GARRISDEAD: return m_auiEncounter[3]; break;
                case DATA_GEDDONISDEAD: return m_auiEncounter[4]; break;
                case DATA_SHAZZRAHISDEAD: return m_auiEncounter[5]; break;
                case DATA_SULFURONISDEAD: return m_auiEncounter[6]; break;
                case DATA_GOLEMAGGISDEAD:  return m_auiEncounter[7]; break;
                case DATA_MAJORDOMOISDEAD:  return m_auiEncounter[8]; break;
                case DATA_RAGNAROSISDEAD: return m_auiEncounter[9]; break;
                case DATA_GOLEMAGG_DEATH: return golemagisdead ? 1 : 0; break;
                case DATA_RAGNAROSISSUMMONED: return ragnarossummoned; break;
            }

            return 0;
        }

        void SetData(uint32 type, uint32 data)
        {
            if (type == DATA_GOLEMAGG_DEATH)
                golemagisdead = true;

            switch(type)
            {
            case DATA_GOLEMAGG_DEATH: golemagisdead = true; break;

            case DATA_LUCIFRONISDEAD:
                if(m_auiEncounter[0] != DONE)
                    m_auiEncounter[0] = data;
                break;
            case DATA_MAGMADARISDEAD:
                if(m_auiEncounter[1] != DONE)
                    m_auiEncounter[1] = data;
                break;
            case DATA_GEHENNASISDEAD:
                if(m_auiEncounter[2] != DONE)
                    m_auiEncounter[2] = data;
                break;
            case DATA_GARRISDEAD:
                if(m_auiEncounter[3] != DONE)
                    m_auiEncounter[3] = data;
                break;
            case DATA_GEDDONISDEAD:
                if(m_auiEncounter[4] != DONE)
                    m_auiEncounter[4] = data;
                break;
            case DATA_SHAZZRAHISDEAD:
                if(m_auiEncounter[5] != DONE)
                    m_auiEncounter[5] = data;
                break;
            case DATA_SULFURONISDEAD:
                if(m_auiEncounter[6] != DONE)
                    m_auiEncounter[6] = data;
                break;
            case DATA_GOLEMAGGISDEAD:
                if(m_auiEncounter[7] != DONE)
                    m_auiEncounter[7] = data;
                break;
            case DATA_MAJORDOMOISDEAD:
                if(m_auiEncounter[8] != DONE)
                {
                    m_auiEncounter[8] = data;

                    if(data == DONE)
                        if(GameObject* pGo = instance->GetGameObject(m_uiFirelordCacheGUID))
                        {
                            pGo->SetRespawnTime(90000000);
                            pGo->Respawn();
                        }
                }
                break;
            case DATA_RAGNAROSISDEAD:
                if(m_auiEncounter[9] != DONE)
                    m_auiEncounter[9] = data;
                break;
            case DATA_RAGNAROSISSUMMONED:
                if(ragnarossummoned != DONE)
                    ragnarossummoned = data;
                break;
                }

            if(data == DONE)
                SaveToDB();
        }

        std::string GetSaveData()
        {
            std::ostringstream ss;
            ss << "M C " 
                << m_auiEncounter[0] << " "
                << m_auiEncounter[1] << " "
                << m_auiEncounter[2] << " "
                << m_auiEncounter[3] << " "
                << m_auiEncounter[4] << " "
                << m_auiEncounter[5] << " "
                << m_auiEncounter[6] << " "
                << m_auiEncounter[7] << " "
                << m_auiEncounter[8] << " "
                << ragnarossummoned  << " "
                << m_auiEncounter[9];

            std::string data = ss.str();

            return data.c_str();
        }

        void Load(const char* load)
        {
            if(!load) return;
            std::istringstream ss(load);
            char dataHead1, dataHead2;
            uint32 data1,data2,data3,data4,data5,data6,data7,data8,data9, data10, data11;
            ss >> dataHead1 >> dataHead2
               >> data1 >> data2 >> data3 >> data4 >> data5
               >> data6 >> data7 >> data8 >> data9 >> data10 >> data11;

            if(dataHead1 == 'M' && dataHead2 == 'C')
            {
                m_auiEncounter[0] = data1;
                m_auiEncounter[1] = data2;
                m_auiEncounter[2] = data3;
                m_auiEncounter[3] = data4;
                m_auiEncounter[4] = data5;
                m_auiEncounter[5] = data6;
                m_auiEncounter[6] = data7;
                m_auiEncounter[7] = data8;
                m_auiEncounter[8] = data9;
                ragnarossummoned = data10;
                m_auiEncounter[9] = data11;
            }else
            {
                sLog->outError("Molten Core: corrupted save data.");
                for(uint8 i = 0; i < MAX_ENCOUNTER; i++)
                    m_auiEncounter[i] = NOT_STARTED;
            }
        }

        void Update (uint32 diff)
        {
        }
    };
};

void AddSC_instance_molten_core()
{
    new instance_molten_core();
}
