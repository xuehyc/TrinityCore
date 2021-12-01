/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_gen_".
 */

 /* ContentData
 npc_pet_gen_baby_blizzard_bear     100%    Baby Blizzard Bear sits down occasionally
 npc_pet_gen_egbert                 100%    Egbert run's around
 npc_pet_gen_pandaren_monk          100%    Pandaren Monk drinks and bows with you
 npc_pet_gen_mojo                   100%    Mojo follows you when you kiss it
 EndContentData */

#include "ScriptMgr.h"
#include "DB2Structure.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "PassiveAI.h"
#include "PetDefines.h"
#include "Player.h"
#include "ScriptedCreature.h"

enum BabyBlizzardBearMisc
{
    SPELL_BBB_PET_SIT = 61853,
    EVENT_BBB_PET_SIT = 1,
    EVENT_BBB_PET_SIT_INTER = 2
};

class npc_pet_gen_baby_blizzard_bear : public CreatureScript
{
public:
    npc_pet_gen_baby_blizzard_bear() : CreatureScript("npc_pet_gen_baby_blizzard_bear") {}

    struct npc_pet_gen_baby_blizzard_bearAI : public NullCreatureAI
    {
        npc_pet_gen_baby_blizzard_bearAI(Creature* creature) : NullCreatureAI(creature)
        {
            if (Unit* owner = me->GetCharmerOrOwner())
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle());
            _events.ScheduleEvent(EVENT_BBB_PET_SIT, urandms(10, 30));
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (Unit* owner = me->GetCharmerOrOwner())
                if (!me->IsWithinDist(owner, 25.f))
                    me->InterruptSpell(CURRENT_CHANNELED_SPELL);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_BBB_PET_SIT:
                    me->CastSpell(me, SPELL_BBB_PET_SIT, false);
                    _events.ScheduleEvent(EVENT_BBB_PET_SIT_INTER, urandms(15, 30));
                    break;
                case EVENT_BBB_PET_SIT_INTER:
                    me->InterruptSpell(CURRENT_CHANNELED_SPELL);
                    _events.ScheduleEvent(EVENT_BBB_PET_SIT, urandms(10, 30));
                    break;
                default:
                    break;
                }
            }
        }

    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_pet_gen_baby_blizzard_bearAI(creature);
    }
};

enum EgbertMisc
{
    SPELL_EGBERT = 40669,
    EVENT_RETURN = 3
};

class npc_pet_gen_egbert : public CreatureScript
{
public:
    npc_pet_gen_egbert() : CreatureScript("npc_pet_gen_egbert") {}

    struct npc_pet_gen_egbertAI : public NullCreatureAI
    {
        npc_pet_gen_egbertAI(Creature* creature) : NullCreatureAI(creature)
        {
            if (Unit* owner = me->GetCharmerOrOwner())
                if (owner->GetMap()->GetEntry()->ExpansionID > 1)
                    me->SetCanFly(true);
        }

        void Reset() override
        {
            _events.Reset();
            if (Unit* owner = me->GetCharmerOrOwner())
                me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle());
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!_EnterEvadeMode(why))
                return;

            Reset();
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (Unit* owner = me->GetCharmerOrOwner())
            {
                if (!me->IsWithinDist(owner, 40.f))
                {
                    me->RemoveAura(SPELL_EGBERT);
                    me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, me->GetFollowAngle());
                }
            }

            if (me->HasAura(SPELL_EGBERT))
                _events.ScheduleEvent(EVENT_RETURN, urandms(5, 20));

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_RETURN:
                    me->RemoveAura(SPELL_EGBERT);
                    break;
                default:
                    break;
                }
            }
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_pet_gen_egbertAI(creature);
    }
};

enum PandarenMonkMisc
{
    SPELL_PANDAREN_MONK = 69800,
    EVENT_FOCUS = 1,
    EVENT_EMOTE = 2,
    EVENT_FOLLOW = 3,
    EVENT_DRINK = 4
};

class npc_pet_gen_pandaren_monk : public CreatureScript
{
public:
    npc_pet_gen_pandaren_monk() : CreatureScript("npc_pet_gen_pandaren_monk") {}

    struct npc_pet_gen_pandaren_monkAI : public NullCreatureAI
    {
        npc_pet_gen_pandaren_monkAI(Creature* creature) : NullCreatureAI(creature) { }

        void Reset() override
        {
            _events.Reset();
            _events.ScheduleEvent(EVENT_FOCUS, 1000);
        }

        void EnterEvadeMode(EvadeReason why) override
        {
            if (!_EnterEvadeMode(why))
                return;

            Reset();
        }

        void ReceiveEmote(Player* /*player*/, uint32 emote) override
        {
            me->InterruptSpell(CURRENT_CHANNELED_SPELL);
            me->StopMoving();

            switch (emote)
            {
            case TEXT_EMOTE_BOW:
                _events.ScheduleEvent(EVENT_FOCUS, 1000);
                break;
            case TEXT_EMOTE_DRINK:
                _events.ScheduleEvent(EVENT_DRINK, 1000);
                break;
            }
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            if (Unit* owner = me->GetCharmerOrOwner())
                if (!me->IsWithinDist(owner, 30.f))
                    me->InterruptSpell(CURRENT_CHANNELED_SPELL);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_FOCUS:
                    if (Unit* owner = me->GetCharmerOrOwner())
                        me->SetFacingToObject(owner);
                    _events.ScheduleEvent(EVENT_EMOTE, 1000);
                    break;
                case EVENT_EMOTE:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
                    _events.ScheduleEvent(EVENT_FOLLOW, 1000);
                    break;
                case EVENT_FOLLOW:
                    if (Unit* owner = me->GetCharmerOrOwner())
                        me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, PET_FOLLOW_ANGLE);
                    break;
                case EVENT_DRINK:
                    me->CastSpell(me, SPELL_PANDAREN_MONK, false);
                    break;
                default:
                    break;
                }
            }
        }
    private:
        EventMap _events;
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_pet_gen_pandaren_monkAI(creature);
    }
};

enum Mojo
{
    SAY_MOJO                = 0,

    SPELL_FEELING_FROGGY    = 43906,
    SPELL_SEDUCTION_VISUAL  = 43919
};

class npc_pet_gen_mojo : public CreatureScript
{
    public:
        npc_pet_gen_mojo() : CreatureScript("npc_pet_gen_mojo") { }

        struct npc_pet_gen_mojoAI : public ScriptedAI
        {
            npc_pet_gen_mojoAI(Creature* creature) : ScriptedAI(creature)
            {
            }

            void Reset() override
            {
                _victimGUID.Clear();

                if (Unit* owner = me->GetOwner())
                    me->GetMotionMaster()->MoveFollow(owner, 0.0f, 0.0f);
            }

            void EnterCombat(Unit* /*who*/) override { }
            void UpdateAI(uint32 /*diff*/) override { }

            void ReceiveEmote(Player* player, uint32 emote) override
            {
                me->HandleEmoteCommand(emote);
                Unit* owner = me->GetOwner();
                if (emote != TEXT_EMOTE_KISS || !owner || owner->GetTypeId() != TYPEID_PLAYER ||
                    owner->ToPlayer()->GetTeam() != player->GetTeam())
                {
                    return;
                }

                Talk(SAY_MOJO, player);

                if (!_victimGUID.IsEmpty())
                    if (Player* victim = ObjectAccessor::GetPlayer(*me, _victimGUID))
                        victim->RemoveAura(SPELL_FEELING_FROGGY);

                _victimGUID = player->GetGUID();

                DoCast(player, SPELL_FEELING_FROGGY, true);
                DoCast(me, SPELL_SEDUCTION_VISUAL, true);
                me->GetMotionMaster()->MoveFollow(player, 0.0f, 0.0f);
            }

        private:
            ObjectGuid _victimGUID;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_pet_gen_mojoAI(creature);
        }
};

void AddSC_generic_pet_scripts()
{
    new npc_pet_gen_baby_blizzard_bear();
    new npc_pet_gen_egbert();
    new npc_pet_gen_pandaren_monk();
    new npc_pet_gen_mojo();
}
