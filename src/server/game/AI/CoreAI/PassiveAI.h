/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_PASSIVEAI_H
#define SERVER_PASSIVEAI_H

#include "CreatureAI.h"

class GAME_API PassiveAI : public CreatureAI
{
    public:
        explicit PassiveAI(Creature* c);

        void MoveInLineOfSight(Unit*) override { }
        void AttackStart(Unit*) override { }
        void UpdateAI(uint32) override;

        static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};

class GAME_API PossessedAI : public CreatureAI
{
    public:
        explicit PossessedAI(Creature* c);

        void MoveInLineOfSight(Unit*) override { }
        void AttackStart(Unit* target) override;
        void UpdateAI(uint32) override;
        void EnterEvadeMode(EvadeReason /*why*/) override { }

        void JustDied(Unit*) override;
        void KilledUnit(Unit* victim) override;

        void OnCharmed(bool /*apply*/) override;

        static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};

class GAME_API NullCreatureAI : public CreatureAI
{
    public:
        explicit NullCreatureAI(Creature* c);

        void MoveInLineOfSight(Unit*) override { }
        void AttackStart(Unit*) override { }
        void UpdateAI(uint32) override { }
        void EnterEvadeMode(EvadeReason /*why*/) override { }
        void OnCharmed(bool /*apply*/) override { }

        static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};

class GAME_API CritterAI : public PassiveAI
{
    public:
        explicit CritterAI(Creature* c) : PassiveAI(c) { }

        void DamageTaken(Unit* done_by, uint32& /*damage*/) override;
        void EnterEvadeMode(EvadeReason why) override;
};

class GAME_API TriggerAI : public NullCreatureAI
{
    public:
        explicit TriggerAI(Creature* c) : NullCreatureAI(c) { }
        void IsSummonedBy(Unit* summoner) override;
};

#endif
