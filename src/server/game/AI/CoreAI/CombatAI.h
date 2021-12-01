/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_COMBATAI_H
#define SERVER_COMBATAI_H

#include "CreatureAI.h"

class Creature;

class GAME_API AggressorAI : public CreatureAI
{
    public:
        explicit AggressorAI(Creature* c) : CreatureAI(c) { }

        void UpdateAI(uint32) override;
        static int Permissible(const Creature*);
};

typedef std::vector<uint32> SpellVct;

class GAME_API CombatAI : public CreatureAI
{
    public:
        explicit CombatAI(Creature* c) : CreatureAI(c) { }

        void InitializeAI() override;
        void Reset() override;
        void EnterCombat(Unit* who) override;
        void JustDied(Unit* killer) override;
        void UpdateAI(uint32 diff) override;
        void SpellInterrupted(uint32 spellId, uint32 unTimeMs) override;

        static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

    protected:
        EventMap events;
        SpellVct spells;
};

class GAME_API CasterAI : public CombatAI
{
    public:
        explicit CasterAI(Creature* c) : CombatAI(c) { m_attackDist = MELEE_RANGE; }
        void InitializeAI() override;
        void AttackStart(Unit* victim) override { AttackStartCaster(victim, m_attackDist); }
        void UpdateAI(uint32 diff) override;
        void EnterCombat(Unit* /*who*/) override;
    private:
        float m_attackDist;
};

struct GAME_API ArcherAI : public CreatureAI
{
    public:
        explicit ArcherAI(Creature* c);
        void AttackStart(Unit* who) override;
        void UpdateAI(uint32 diff) override;

        static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

    protected:
        float m_minRange;
};

struct GAME_API TurretAI : public CreatureAI
{
    public:
        explicit TurretAI(Creature* c);
        bool CanAIAttack(Unit const* who) const override;
        void AttackStart(Unit* who) override;
        void UpdateAI(uint32 diff) override;

        static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

    protected:
        float m_minRange;
};

#define VEHICLE_CONDITION_CHECK_TIME 1000
#define VEHICLE_DISMISS_TIME 5000

struct GAME_API VehicleAI : public CreatureAI
{
    public:
        explicit VehicleAI(Creature* creature);

        void UpdateAI(uint32 diff) override;
        void MoveInLineOfSight(Unit*) override { }
        void AttackStart(Unit*) override { }
        void OnCharmed(bool apply) override;

        static int Permissible(Creature const* /*creature*/) { return PERMIT_BASE_NO; }

    private:
        void LoadConditions();
        void CheckConditions(uint32 diff);
        bool m_HasConditions;
        uint32 m_ConditionsTimer;
        bool m_DoDismiss;
        uint32 m_DismissTimer;
};

#endif
