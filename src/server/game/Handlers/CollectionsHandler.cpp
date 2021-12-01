/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "WorldSession.h"
#include "CollectionMgr.h"
#include "CollectionPackets.h"

void WorldSession::HandleCollectionItemSetFavorite(WorldPackets::Collections::CollectionItemSetFavorite& collectionItemSetFavorite)
{
    switch (collectionItemSetFavorite.Type)
    {
        case WorldPackets::Collections::TOYBOX:
            GetCollectionMgr()->ToySetFavorite(collectionItemSetFavorite.ID, collectionItemSetFavorite.IsFavorite);
            break;
        case WorldPackets::Collections::APPEARANCE:
        {
            bool hasAppearance, isTemporary;
            std::tie(hasAppearance, isTemporary) = GetCollectionMgr()->HasItemAppearance(collectionItemSetFavorite.ID);
            if (!hasAppearance || isTemporary)
                return;

            GetCollectionMgr()->SetAppearanceIsFavorite(collectionItemSetFavorite.ID, collectionItemSetFavorite.IsFavorite);
            break;
        }
        case WorldPackets::Collections::TRANSMOG_SET:
            break;
        default:
            break;
    }
}
