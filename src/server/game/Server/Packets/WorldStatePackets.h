/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef WorldStatePackets_h__
#define WorldStatePackets_h__

#include "Packet.h"

namespace WorldPackets
{
    namespace WorldState
    {
        class InitWorldStates final : public ServerPacket
        {
        public:
            struct WorldStateInfo
            {
                WorldStateInfo(uint32 variableID, int32 value)
                    : VariableID(variableID), Value(value) { }

                uint32 VariableID;
                int32 Value;
            };

            InitWorldStates();

            WorldPacket const* Write() override;

            uint32 AreaID    = 0; ///< ZoneId
            uint32 SubareaID = 0; ///< AreaId
            uint32 MapID     = 0; ///< MapId

            std::vector<WorldStateInfo> Worldstates;
        };

        class UpdateWorldState final : public ServerPacket
        {
        public:
            UpdateWorldState();

            WorldPacket const* Write() override;

            int32 Value       = 0;
            bool Hidden   = false; ///< @todo: research
            uint32 VariableID = 0;
        };
    }
}

#endif // WorldStatePackets_h__
