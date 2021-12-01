/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef InstanceScenario_h__
#define InstanceScenario_h__

#include "Scenario.h"

class Map;

typedef std::unordered_map<uint8, CriteriaProgressMap> StepCriteriaProgressMap;

class GAME_API InstanceScenario : public Scenario
{
    public:
        InstanceScenario(Map const* map, ScenarioData const* scenarioData);

        void SaveToDB();
        void LoadInstanceData(uint32 instanceId);

    protected:
        std::string GetOwnerInfo() const override;
        void SendPacket(WorldPacket const* data) const override;

        Map const* _map;
        ScenarioData const* _data;
        StepCriteriaProgressMap _stepCriteriaProgress;
};

#endif // InstanceScenario_h__
