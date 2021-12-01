/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_GUARDAI_H
#define SERVER_GUARDAI_H

#include "ScriptedCreature.h"

class Creature;

class GAME_API GuardAI : public ScriptedAI
{
    public:
        explicit GuardAI(Creature* creature);

        static int Permissible(Creature const* creature);
        void UpdateAI(uint32 diff) override;
        bool CanSeeAlways(WorldObject const* obj) override;

        void EnterEvadeMode(EvadeReason /*why*/) override;
        void JustDied(Unit* killer) override;
};
#endif
