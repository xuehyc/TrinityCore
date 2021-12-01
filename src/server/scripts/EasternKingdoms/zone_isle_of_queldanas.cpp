/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/* ScriptData
SDName: Isle_of_Queldanas
SD%Complete: 100
SDComment: Quest support: 11541
SDCategory: Isle Of Quel'Danas
EndScriptData */

/* ContentData
npc_greengill_slave
EndContentData */

#include "ScriptMgr.h"
#include "Player.h"
#include "ScriptedCreature.h"
#include "SpellInfo.h"

/*######
## npc_greengill_slave
######*/

enum GreengillSlave
{
    NPC_DARKSPINE_MYRIDON       = 25060,
    QUEST_GREENGILL_COAST       = 11541,
    SPELL_ENRAGE                = 45111,
    SPELL_ORB_MURLOC_CONTROL    = 45109,
    SPELL_GREENGILL_SLAVE_FREED = 45110
};

class npc_greengill_slave : public CreatureScript
{
public:
    npc_greengill_slave() : CreatureScript("npc_greengill_slave") { }

    struct npc_greengill_slaveAI : public ScriptedAI
    {
        npc_greengill_slaveAI(Creature* creature) : ScriptedAI(creature) { }

        void SpellHit(Unit* caster, SpellInfo const* spellInfo) override
        {
            Player* player = caster->ToPlayer();

            if (!player)
                return;

            if (spellInfo->Id == SPELL_ORB_MURLOC_CONTROL && !me->HasAura(SPELL_ENRAGE))
            {
                if (player->GetQuestStatus(QUEST_GREENGILL_COAST) == QUEST_STATUS_INCOMPLETE)
                    DoCast(player, SPELL_GREENGILL_SLAVE_FREED, true);

                DoCast(me, SPELL_ENRAGE);

                if (Creature* Myrmidon = me->FindNearestCreature(NPC_DARKSPINE_MYRIDON, 70))
                {
                    me->AddThreat(Myrmidon, 100000.0f);
                    AttackStart(Myrmidon);
                }
            }
        }

        void UpdateAI(uint32 /*diff*/) override
        {
            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_greengill_slaveAI(creature);
    }
};

void AddSC_isle_of_queldanas()
{
    new npc_greengill_slave();
}
