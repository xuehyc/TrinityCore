/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "PassiveAI.h"
#include "ScriptedCreature.h"
#include "SpellMgr.h"

class trigger_periodic : public CreatureScript
{
public:
    trigger_periodic() : CreatureScript("trigger_periodic") { }

    struct trigger_periodicAI : public NullCreatureAI
    {
        trigger_periodicAI(Creature* creature) : NullCreatureAI(creature)
        {
            spell = me->m_spells[0] ? sSpellMgr->GetSpellInfo(me->m_spells[0]) : NULL;
            interval = me->GetBaseAttackTime(BASE_ATTACK);
            timer = interval;
        }

        uint32 timer, interval;
        const SpellInfo* spell;

        void UpdateAI(uint32 diff) override
        {
            if (timer <= diff)
            {
                if (spell)
                    me->CastSpell(me, spell, true);
                timer = interval;
            }
            else
                timer -= diff;
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new trigger_periodicAI(creature);
    }
};

void AddSC_generic_creature()
{
    new trigger_periodic();
}
