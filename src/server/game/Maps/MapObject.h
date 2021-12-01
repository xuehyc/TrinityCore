/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef MapObject_h__
#define MapObject_h__

#include "Define.h"
#include "Cell.h"
#include "Position.h"

class Map;
class ObjectGridLoader;

enum MapObjectCellMoveState
{
    MAP_OBJECT_CELL_MOVE_NONE, //not in move list
    MAP_OBJECT_CELL_MOVE_ACTIVE, //in move list
    MAP_OBJECT_CELL_MOVE_INACTIVE, //in move list but should not move
};

class GAME_API MapObject
{
    friend class Map; //map for moving creatures
    friend class ObjectGridLoader; //grid loader for loading creatures

protected:
    MapObject() : _moveState(MAP_OBJECT_CELL_MOVE_NONE)
    {
        _newPosition.Relocate(0.0f, 0.0f, 0.0f, 0.0f);
    }

private:
    Cell _currentCell;
    Cell const& GetCurrentCell() const { return _currentCell; }
    void SetCurrentCell(Cell const& cell) { _currentCell = cell; }

    MapObjectCellMoveState _moveState;
    Position _newPosition;
    void SetNewCellPosition(float x, float y, float z, float o)
    {
        _moveState = MAP_OBJECT_CELL_MOVE_ACTIVE;
        _newPosition.Relocate(x, y, z, o);
    }
};

#endif // MapObject_h__
