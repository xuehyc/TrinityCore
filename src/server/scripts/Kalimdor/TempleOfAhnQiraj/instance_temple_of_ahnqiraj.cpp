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
SDName: Instance_Temple_of_Ahnqiraj
SD%Complete: 80
SDComment:
SDCategory: Temple of Ahn'Qiraj
EndScriptData */

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "CreatureAI.h"
#include "temple_of_ahnqiraj.h"

class instance_temple_of_ahnqiraj : public InstanceMapScript
{
    public:
        instance_temple_of_ahnqiraj() : InstanceMapScript("instance_temple_of_ahnqiraj", 531) { }

        struct instance_temple_of_ahnqiraj_InstanceMapScript : public InstanceScript
        {
            instance_temple_of_ahnqiraj_InstanceMapScript(Map* map) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTER);

                _skeramGUID     = 0;
                _veklorGUID     = 0;
                _veknilashGUID  = 0;
                _cthunPhase     = 0;
                _yaujGUID       = 0;
                _kriGUID        = 0;
                _vemGUID        = 0;
                lastBugKilledGUID  = 0;
            }

            void OnCreatureCreate(Creature* creature)
            {
                switch (creature->GetEntry())
                {
                    case NPC_SKERAM:
                        _skeramGUID = creature->GetGUID();
                        break;
                    case NPC_VEKLOR:
                        _veklorGUID = creature->GetGUID();
                        break;
                    case NPC_VEKNILASH:
                        _veknilashGUID = creature->GetGUID();
                        break;
                    case NPC_KRI:
                        _kriGUID = creature->GetGUID();
                        break;
                    case NPC_VEM:
                        _vemGUID = creature->GetGUID();
                        break;
                    case BOSS_YAUJ:
                        _yaujGUID = creature->GetGUID();
                        break;
                }
            }

            void SetData(uint32 type, uint32 data)
            {
                switch(type)
                {
                    case DATA_CTHUN_PHASE:
                        _cthunPhase = data;
                        break;
                }
            }

            bool SetBossState(uint32 bossId, EncounterState state)
            {
                if (!InstanceScript::SetBossState(bossId, state))
                    return false;
  
                switch (bossId)
                {
                    case BOSS_BUG_TRIO:
                        if (state == DONE)
                        {
                            if (Creature* lastKilled = instance->GetCreature(lastBugKilledGUID))
                               lastKilled->SetFlag(UNIT_DYNAMIC_FLAGS, UNIT_DYNFLAG_LOOTABLE);
                        }
                        break;
                    case BOSS_KRI:
                    case BOSS_VEM:
                    case BOSS_YAUJ:
                        if (state == NOT_STARTED)
                        {
                            if (Creature* bug = instance->GetCreature(GetData64(bossId)))
                            {
                                if (!bug->isAlive())
                                    bug->Respawn();
                                bug->AI()->EnterEvadeMode();
                            }
                        }
                        else if (state == DONE)
                            lastBugKilledGUID = GetData64(bossId);
                        break;
                    default:
                        break;
                }
                return true;
            }

            uint32 GetData(uint32 type)
            {
                switch (type)
                {
                    case DATA_CTHUN_PHASE:
                        return _cthunPhase;
                }
                return 0;
            }

            uint64 GetData64(uint32 type)
            {
                switch (type)
                {
                    case BOSS_SKERAM:
                        return _skeramGUID;
                    case BOSS_VEKLOR:
                        return _veklorGUID;
                    case BOSS_VEKNILASH:
                        return _veknilashGUID;
                    case BOSS_KRI:
                        return _kriGUID;
                    case BOSS_YAUJ:
                        return _yaujGUID;
					case BOSS_VEM:
                        return _vemGUID;
                }

                return 0;
            }

            std::string GetSaveData()
            {
                OUT_SAVE_INST_DATA;

                std::ostringstream saveStream;
                saveStream << "A Q T " << GetBossSaveData();

                OUT_SAVE_INST_DATA_COMPLETE;
                return saveStream.str();
            }

            void Load(char const* data)
            {
                if (!data)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(data);

                char dataHead1, dataHead2, dataHead3;

                std::istringstream loadStream(data);
                loadStream >> dataHead1 >> dataHead2 >> dataHead3;

                if (dataHead1 == 'A' && dataHead2 == 'Q' && dataHead3 == 'T')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > TO_BE_DECIDED)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                }
                else
                    OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

        private:
            uint64 _skeramGUID;
            uint64 _veklorGUID;
            uint64 _veknilashGUID;
            uint64 _yaujGUID;
            uint64 _kriGUID;
            uint64 _vemGUID;
            uint64 lastBugKilledGUID;
            uint8 _cthunPhase;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_temple_of_ahnqiraj_InstanceMapScript(map);
        }
};


void AddSC_instance_temple_of_ahnqiraj()
{
    new instance_temple_of_ahnqiraj();
}
