/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/* ScriptData
SDName: Boss_Death_knight_darkreaver
SD%Complete: 100
SDComment:
SDCategory: Scholomance
EndScriptData */

#include "ScriptMgr.h"
#include "scholomance.h"
#include "ScriptedCreature.h"

class boss_death_knight_darkreaver : public CreatureScript
{
public:
    boss_death_knight_darkreaver() : CreatureScript("boss_death_knight_darkreaver") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return GetScholomanceAI<boss_death_knight_darkreaverAI>(creature);
    }

    struct boss_death_knight_darkreaverAI : public ScriptedAI
    {
        boss_death_knight_darkreaverAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
        }

        void DamageTaken(Unit* /*done_by*/, uint32 &damage) override
        {
            if (me->GetHealth() <= damage)
                DoCast(me, 23261, true);   //Summon Darkreaver's Fallen Charger
        }

        void EnterCombat(Unit* /*who*/) override
        {
        }
    };

};

void AddSC_boss_death_knight_darkreaver()
{
    new boss_death_knight_darkreaver();
}
