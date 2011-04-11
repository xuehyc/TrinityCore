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
SDName: Instance_Arcatraz
SD%Complete: 80
SDComment: Mainly Harbringer Skyriss event
SDCategory: Tempest Keep, The Arcatraz
EndScriptData */

#include "ScriptPCH.h"
#include "arcatraz.h"

#define MAX_ENCOUNTER 9

#define CONTAINMENT_CORE_SECURITY_FIELD_ALPHA 184318        //door opened when Wrath-Scryer Soccothrates dies
#define CONTAINMENT_CORE_SECURITY_FIELD_BETA  184319        //door opened when Dalliah the Doomsayer dies
#define POD_ALPHA   183961                                  //pod first boss wave
#define POD_BETA    183963                                  //pod second boss wave
#define POD_DELTA   183964                                  //pod third boss wave
#define POD_GAMMA   183962                                  //pod fourth boss wave
#define POD_OMEGA   183965                                  //pod fifth boss wave
#define WARDENS_SHIELD  184802                              // warden shield
#define SEAL_SPHERE 184802                                  //shield 'protecting' mellichar

#define MELLICHAR   20904                                   //skyriss will kill this unit
#define ARCA_SPAWN_TRIGGER 21186                            //we need this for spawning Proteans and Eredars

// creature IDs for Eredars
#define ENTRY_EREDAR_DEATHBRINGER   20880
#define ENTRY_EREDAR_SOULEATER      20879

float eredar_spawnpoint[3][4] =
{
    {301.82f, 127.72f, 22.3f, 1.59f},
    {287.10f, 144.95f, 22.3f, 0.27f},
    {305.09f, 149.06f, 24.9f, 3.94f}
};

/* Arcatraz encounters:
1 - Zereketh the Unbound event
2 - Dalliah the Doomsayer event
3 - Wrath-Scryer Soccothrates event
4 - Harbinger Skyriss event, 5 sub-events
*/

class instance_arcatraz : public InstanceMapScript
{
public:
    instance_arcatraz() : InstanceMapScript("instance_arcatraz", 552) { }

    InstanceScript* GetInstanceScript(InstanceMap* pMap) const
    {
        return new instance_arcatraz_InstanceMapScript(pMap);
    }

    struct instance_arcatraz_InstanceMapScript : public InstanceScript
    {
            instance_arcatraz_InstanceMapScript(Map* pMap) : InstanceScript(pMap) {}

        uint32 m_auiEncounter[MAX_ENCOUNTER];

        uint64 Containment_Core_Security_Field_Alpha;
        uint64 Containment_Core_Security_Field_Beta;
        GameObject *Pod_Alpha;
        GameObject *Pod_Gamma;
        GameObject *Pod_Beta;
        GameObject *Pod_Delta;
        GameObject *Pod_Omega;
        GameObject *Wardens_Shield;

        uint64 GoSphereGUID;
        uint64 MellicharGUID;

        uint32 socco_dead;
        uint32 dalli_dead;
        uint64 dalli_guid;
        uint64 socco_guid;
        uint32 d_hp25;
        uint32 s_hp25;

        uint64 arca_spawn_triggerGUID;
        uint64 eredar_spawn[3];

        void Initialize()
        {
            memset(&m_auiEncounter, 0, sizeof(m_auiEncounter));

            Containment_Core_Security_Field_Alpha = NULL;
            Containment_Core_Security_Field_Beta  = NULL;
            Pod_Alpha = NULL;
            Pod_Beta  = NULL;
            Pod_Delta = NULL;
            Pod_Gamma = NULL;
            Pod_Omega = NULL;
            Wardens_Shield = NULL;

            socco_dead = NOT_STARTED;
            dalli_dead = NOT_STARTED;

            GoSphereGUID = NULL;
            MellicharGUID = NULL;
            dalli_guid = NULL;
            socco_guid = NULL;
            d_hp25 = NULL;
            s_hp25 = NULL;

            memset(&eredar_spawn, 0, sizeof(eredar_spawn));
        }

        bool IsEncounterInProgress() const
        {
            for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                if (m_auiEncounter[i] == IN_PROGRESS) return true;

            return false;
        }

        void OnGameObjectCreate(GameObject* pGo)
        {
            switch(pGo->GetEntry())
            {
                case CONTAINMENT_CORE_SECURITY_FIELD_ALPHA: 
                    Containment_Core_Security_Field_Alpha = pGo->GetGUID();
                    if(socco_dead == DONE)
                        HandleGameObject(Containment_Core_Security_Field_Alpha,true,pGo);
                    else
                        HandleGameObject(Containment_Core_Security_Field_Alpha,false,pGo);
                    break;
                case CONTAINMENT_CORE_SECURITY_FIELD_BETA:
                    Containment_Core_Security_Field_Beta = pGo->GetGUID();
                     if(dalli_dead == DONE)
                        HandleGameObject(Containment_Core_Security_Field_Beta,true,pGo);
                    else
                        HandleGameObject(Containment_Core_Security_Field_Beta,false,pGo);
                    break;
                    break;
                case SEAL_SPHERE: GoSphereGUID = pGo->GetGUID(); break;
                case POD_ALPHA: Pod_Alpha = pGo; break;
                case POD_BETA:  Pod_Beta =  pGo; break;
                case POD_DELTA: Pod_Delta = pGo; break;
                case POD_GAMMA: Pod_Gamma = pGo; break;
                case POD_OMEGA: Pod_Omega = pGo; break;
                //case WARDENS_SHIELD: Wardens_Shield = pGo; break;
            }
        }

        void OnCreatureCreate(Creature* pCreature)
        {
            switch(pCreature->GetEntry())
            {
            case MELLICHAR:
                MellicharGUID = pCreature->GetGUID();
                break;
            case 20885:
                dalli_guid  = pCreature->GetGUID();
                break;
            case 20886:
                socco_guid = pCreature->GetGUID();
                break;
            case ARCA_SPAWN_TRIGGER:
                SpawnEredar(pCreature);
                break;
            }
        }

        void SetData(uint32 type, uint32 data)
        {
            switch(type)
            {
                case TYPE_ZEREKETH:
                    m_auiEncounter[0] = data;
                    break;

                case DATA_WRATH_SCRYERSOCCOTHRATESEVENT:
                    if (data == DONE)
                        HandleGameObject(Containment_Core_Security_Field_Beta,true);
                    if(m_auiEncounter[1] != DONE)
                        m_auiEncounter[1] = data;
                    break;

                case DATA_DALLIAHTHEDOOMSAYEREVENT:
                    if (data == DONE)
                        HandleGameObject(Containment_Core_Security_Field_Alpha,true);
                    if(m_auiEncounter[2] != DONE)
                        m_auiEncounter[2] = data;
                    break;

                case TYPE_HARBINGERSKYRISS:
                    if (data == NOT_STARTED || data == FAIL)
                    {
                        m_auiEncounter[4] = NOT_STARTED;
                        m_auiEncounter[5] = NOT_STARTED;
                        m_auiEncounter[6] = NOT_STARTED;
                        m_auiEncounter[7] = NOT_STARTED;
                        m_auiEncounter[8] = NOT_STARTED;
                    }
                    m_auiEncounter[3] = data;
                    break;

                case TYPE_WARDEN_1:
                    if (data == IN_PROGRESS)
                        if (Pod_Alpha)
                            Pod_Alpha->UseDoorOrButton();
                    m_auiEncounter[4] = data;
                    break;

                case TYPE_WARDEN_2:
                    if (data == IN_PROGRESS)
                        if (Pod_Beta)
                            Pod_Beta->UseDoorOrButton();
                    m_auiEncounter[5] = data;
                    break;

                case TYPE_WARDEN_3:
                    if (data == IN_PROGRESS)
                        if (Pod_Delta)
                            Pod_Delta->UseDoorOrButton();
                    m_auiEncounter[6] = data;
                    break;

                case TYPE_WARDEN_4:
                    if (data == IN_PROGRESS)
                        if (Pod_Gamma)
                            Pod_Gamma->UseDoorOrButton();
                    m_auiEncounter[7] = data;
                    break;

                case TYPE_WARDEN_5:
                    if (data == IN_PROGRESS)
                        if (Pod_Omega)
                            Pod_Omega->UseDoorOrButton();
                    m_auiEncounter[8] = data;
                    break;

                case TYPE_SHIELD_OPEN:
                    if (data == IN_PROGRESS)
                        if (Wardens_Shield)
                            Wardens_Shield->UseDoorOrButton();
                    break;

                case DATA_DALLIAH25:
                    d_hp25 = data;
                    break;
                case DATA_SOCCOTHRATES25:
                    s_hp25 = data;
                    break;
            }

            SaveToDB();
        }

        uint32 GetData(uint32 type)
        {
             switch(type)
            {
                case TYPE_HARBINGERSKYRISS:
                    return m_auiEncounter[3];
                case TYPE_WARDEN_1:
                    return m_auiEncounter[4];
                case TYPE_WARDEN_2:
                    return m_auiEncounter[5];
                case TYPE_WARDEN_3:
                    return m_auiEncounter[6];
                case TYPE_WARDEN_4:
                    return m_auiEncounter[7];
                case TYPE_WARDEN_5:
                    return m_auiEncounter[8];
                case DATA_DALLIAH25:
                    return d_hp25;
                break;
                case DATA_SOCCOTHRATES25:
                    return s_hp25;
                break;
                case DATA_WRATH_SCRYERSOCCOTHRATESEVENT:
                    return m_auiEncounter[1];
                break;
                case DATA_DALLIAHTHEDOOMSAYEREVENT:
                    return m_auiEncounter[2];
                break;
            }
            return 0;
        }

        uint64 GetData64(uint32 data)
        {
            switch(data)
            {
                case DATA_MELLICHAR:
                    return MellicharGUID;
                case DATA_SPHERE_SHIELD:
                    return GoSphereGUID;
                case DATA_WRATH_SCRYERSOCCOTHRATES:
                    return socco_guid;
                break;
                case DATA_DALLIAHTHEDOOMSAYER:
                    return dalli_guid;
                break;
            }
            return 0;
        }

        std::string GetSaveData()
        {
            std::ostringstream ss;
            ss << "A T " << socco_dead << " " << dalli_dead;
            return ss.str();;
        }

        void Load(const char* load)
        {
            if(!load) return;
            std::istringstream ss(load);
            char dataHead1;
            char dataHead2;
            uint32 data1, data2;
            ss >> dataHead1 >> dataHead2 >> data1 >> data2;
            if(dataHead1 == 'A' && dataHead2 == 'T')
            {
                socco_dead = data1;
                dalli_dead = data2;
            }else sLog->outError("SD2: Arcatraz: corrupted save data.");
        }
    
    /*###
    Randomly Spawn Eredar Deathbringer and Souleater
    ###*/

        void SpawnEredar (Creature* reference)
        {
            if(!reference)
                return;

            if(eredar_spawn[0] != 0 || eredar_spawn[1] != 0 || eredar_spawn[2] != 0)
                return;

            uint32 eredar_entry[3];
            for(uint8 i = 0; i < 3; i++)
            {
                eredar_entry[i] = RAND(ENTRY_EREDAR_DEATHBRINGER,ENTRY_EREDAR_SOULEATER);
            }

            if(eredar_entry[0] == eredar_entry[1] == eredar_entry[2])
            {
                uint32 temp_rand = urand(0,2);
                eredar_entry[temp_rand] = (eredar_entry[temp_rand] == ENTRY_EREDAR_DEATHBRINGER ? ENTRY_EREDAR_SOULEATER : ENTRY_EREDAR_DEATHBRINGER);
            }

            Creature* temp;
            for(uint8 i = 0; i < 3; i++)
            {
                temp = reference->SummonCreature(eredar_entry[i],eredar_spawnpoint[i][0],eredar_spawnpoint[i][1],eredar_spawnpoint[i][2],eredar_spawnpoint[i][3],TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,600000);
                eredar_spawn[i] = temp->GetGUID();
            }
        }
    };
};

void AddSC_instance_arcatraz()
{
    new instance_arcatraz();
}
