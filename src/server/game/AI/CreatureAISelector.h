/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef SERVER_CREATUREAISELECTOR_H
#define SERVER_CREATUREAISELECTOR_H

class CreatureAI;
class Creature;
class MovementGenerator;
class GameObjectAI;
class GameObject;

namespace FactorySelector
{
    GAME_API CreatureAI* selectAI(Creature*);
    GAME_API MovementGenerator* selectMovementGenerator(Creature*);
    GAME_API GameObjectAI* SelectGameObjectAI(GameObject*);
}
#endif
