/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_TOTEMAI_H
#define SERVER_TOTEMAI_H

#include "CreatureAI.h"
#include "Timer.h"

class Creature;
class Totem;

class GAME_API TotemAI : public CreatureAI
{
    public:

        explicit TotemAI(Creature* c);

        void MoveInLineOfSight(Unit* who) override;
        void AttackStart(Unit* victim) override;
        void EnterEvadeMode(EvadeReason /*why*/) override;

        void UpdateAI(uint32 diff) override;
        static int Permissible(Creature const* creature);

    private:
        ObjectGuid i_victimGuid;
};
#endif
