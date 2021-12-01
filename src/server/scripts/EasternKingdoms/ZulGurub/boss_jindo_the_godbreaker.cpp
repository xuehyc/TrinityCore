/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ObjectMgr.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Yells
{
    // Jin'do the Godbreaker
    SAY_INTRO                   = 0,
    SAY_AGGRO                   = 1,
    EMOTE_SHADOWS_OF_HAKKAR     = 2, // ID - 97172 Shadows of Hakkar
    SAY_JINDO_SPIRIT_PHASE      = 3,
    //SAY_PLAYER_KILL             = 4, // missing data

    // Spirit of Hakkar
    SAY_SPIRIT_SPIRIT_PHASE     = 0,
    SAY_SPIRIT_DEFEATED         = 1,

    // Jin'do the Godbreaker - Trigger
    SAY_JINDO_DEFEATED          = 0,

    // Shadow of Hakkar
    SAY_SHADOW_DEFEATED         = 0,
};

enum Spells
{
};

enum Events
{
};

class boss_jindo_the_godbreaker : public CreatureScript
{
    public:
        boss_jindo_the_godbreaker() : CreatureScript("boss_jindo_the_godbreaker") { }

        struct boss_jindo_the_godbreakerAI : public BossAI
        {
            boss_jindo_the_godbreakerAI(Creature* creature) : BossAI(creature, DATA_JINDO) { }

            void Reset() override
            {
                _Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                _EnterCombat();
                Talk(SAY_AGGRO);
            }

            void JustDied(Unit* /*killer*/) override
            {
            }

            void UpdateAI(uint32 diff) override
            {
                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;
                /*
                while (uint32 eventId = events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        default:
                            break;
                    }
                }
                */

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return GetZulGurubAI<boss_jindo_the_godbreakerAI>(creature);
        }
};

void AddSC_boss_jindo_the_godbreaker()
{
    new boss_jindo_the_godbreaker();
}
