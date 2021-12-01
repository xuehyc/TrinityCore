/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "ScenarioMgr.h"
#include "ScenarioPackets.h"
#include "WorldSession.h"

void WorldSession::HandleQueryScenarioPOI(WorldPackets::Scenario::QueryScenarioPOI& queryScenarioPOI)
{
    WorldPackets::Scenario::ScenarioPOIs response;

    // Read criteria tree ids and add the in a unordered_set so we don't send POIs for the same criteria tree multiple times
    std::unordered_set<int32> criteriaTreeIds;
    for (size_t i = 0; i < queryScenarioPOI.MissingScenarioPOIs.size(); ++i)
        criteriaTreeIds.insert(queryScenarioPOI.MissingScenarioPOIs[i]); // CriteriaTreeID

    for (int32 criteriaTreeId : criteriaTreeIds)
    {
        if (ScenarioPOIVector const* poiVector = sScenarioMgr->GetScenarioPOIs(criteriaTreeId))
        {
            WorldPackets::Scenario::ScenarioPOIData scenarioPOIData;
            scenarioPOIData.CriteriaTreeID = criteriaTreeId;
            scenarioPOIData.ScenarioPOIs = poiVector;
            response.ScenarioPOIDataStats.push_back(scenarioPOIData);
        }
    }

    SendPacket(response.Write());
}
