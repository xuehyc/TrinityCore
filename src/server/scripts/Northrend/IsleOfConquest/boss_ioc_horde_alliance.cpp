/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptMgr.h"
#include "BattlegroundIC.h"
#include "ScriptedCreature.h"

enum BossSpells
{
    SPELL_BRUTAL_STRIKE       = 58460,
    SPELL_DAGGER_THROW        = 67280,
    SPELL_CRUSHING_LEAP       = 68506,
    SPELL_RAGE                = 66776
};

enum BossEvents
{
    EVENT_BRUTAL_STRIKE       = 1,
    EVENT_DAGGER_THROW        = 2,
    EVENT_CRUSHING_LEAP       = 3,
    EVENT_CHECK_RANGE         = 4
};

class boss_ioc_horde_alliance : public CreatureScript
{
public:
    boss_ioc_horde_alliance() : CreatureScript("boss_ioc_horde_alliance") { }

    struct boss_ioc_horde_allianceAI : public ScriptedAI
    {
        boss_ioc_horde_allianceAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() override
        {
            _events.Reset();

            uint32 _npcGuard;
            if (me->GetEntry() == NPC_HIGH_COMMANDER_HALFORD_WYRMBANE)
                _npcGuard = NPC_SEVEN_TH_LEGION_INFANTRY;
            else
                _npcGuard = NPC_KOR_KRON_GUARD;

            std::list<Creature*> guardsList;
            me->GetCreatureListWithEntryInGrid(guardsList, _npcGuard, 100.0f);
            for (std::list<Creature*>::const_iterator itr = guardsList.begin(); itr != guardsList.end(); ++itr)
                (*itr)->Respawn();
        };

        void EnterCombat(Unit* /*who*/) override
        {
            _events.ScheduleEvent(EVENT_BRUTAL_STRIKE, 5 * IN_MILLISECONDS);
            _events.ScheduleEvent(EVENT_DAGGER_THROW,  7 * IN_MILLISECONDS);
            _events.ScheduleEvent(EVENT_CHECK_RANGE,   1 * IN_MILLISECONDS);
            _events.ScheduleEvent(EVENT_CRUSHING_LEAP, 15 * IN_MILLISECONDS);
        }

        void SpellHit(Unit* caster, SpellInfo const* /*spell*/) override
        {
            if (caster->IsVehicle())
                me->Kill(caster);
        }

        void UpdateAI(uint32 diff) override
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_BRUTAL_STRIKE:
                        DoCastVictim(SPELL_BRUTAL_STRIKE);
                        _events.ScheduleEvent(EVENT_BRUTAL_STRIKE, 5 * IN_MILLISECONDS);
                        break;
                    case EVENT_DAGGER_THROW:
                        if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 1))
                            DoCast(target, SPELL_DAGGER_THROW);
                        _events.ScheduleEvent(EVENT_DAGGER_THROW, 7 * IN_MILLISECONDS);
                        break;
                    case EVENT_CRUSHING_LEAP:
                        DoCastVictim(SPELL_CRUSHING_LEAP);
                        _events.ScheduleEvent(EVENT_CRUSHING_LEAP, 25 * IN_MILLISECONDS);
                        break;
                    case EVENT_CHECK_RANGE:
                        if (me->GetDistance(me->GetHomePosition()) > 25.0f)
                            DoCast(me, SPELL_RAGE);
                        else
                            me->RemoveAurasDueToSpell(SPELL_RAGE);
                        _events.ScheduleEvent(EVENT_CHECK_RANGE, 1 * IN_MILLISECONDS);
                        break;
                    default:
                        break;
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new boss_ioc_horde_allianceAI(creature);
    }
};

void AddSC_boss_ioc_horde_alliance()
{
    new boss_ioc_horde_alliance();
}
