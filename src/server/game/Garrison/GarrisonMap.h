/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef GarrisonMap_h__
#define GarrisonMap_h__

#include "Map.h"

class Garrison;
class Player;

class GAME_API GarrisonMap : public Map
{
public:
    GarrisonMap(uint32 id, time_t, uint32 instanceId, Map* parent, ObjectGuid const& owner);

    void LoadGridObjects(NGridType* grid, Cell const& cell) override;
    Garrison* GetGarrison();

    void InitVisibilityDistance() override;

    bool AddPlayerToMap(Player* player, bool initPlayer = true) override;

private:
    ObjectGuid _owner;
    Player* _loadingPlayer; ///< @workaround Player is not registered in ObjectAccessor during login
};

#endif // GarrisonMap_h__
