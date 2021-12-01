/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_REACTORAI_H
#define SERVER_REACTORAI_H

#include "CreatureAI.h"

class GAME_API ReactorAI : public CreatureAI
{
    public:

        explicit ReactorAI(Creature* c) : CreatureAI(c) { }

        void MoveInLineOfSight(Unit*) override { }
        void UpdateAI(uint32 diff) override;

        static int Permissible(const Creature*);
};
#endif
