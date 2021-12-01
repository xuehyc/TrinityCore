/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScriptedCreature.h"

// Base class for FALRIC and MARWYN
struct boss_horAI : BossAI
{
    boss_horAI(Creature* creature, uint32 bossId);
    void Reset() override;
    void DoAction(int32 actionId) override;
    void JustSummoned(Creature* summon) override;
};
