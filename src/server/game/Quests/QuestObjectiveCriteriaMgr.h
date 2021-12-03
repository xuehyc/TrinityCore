/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef QuestObjectiveCriteriaMgr_h__
#define QuestObjectiveCriteriaMgr_h__

#include "CriteriaHandler.h"

class GAME_API QuestObjectiveCriteriaMgr : public CriteriaHandler
{
public:
    explicit QuestObjectiveCriteriaMgr(Player* owner);
    ~QuestObjectiveCriteriaMgr();

    void CheckAllQuestObjectiveCriteria(Player* referencePlayer);

    void Reset() override;

    static void DeleteFromDB(ObjectGuid const& guid);
    void LoadFromDB(PreparedQueryResult objectiveResult, PreparedQueryResult criteriaResult);
    void SaveToDB(CharacterDatabaseTransaction& trans);

    void ResetCriteria(CriteriaCondition condition, int32 failAsset, bool evenIfCriteriaComplete = false);
    void ResetCriteriaTree(uint32 criteriaTreeId);

    void SendAllData(Player const* receiver) const override;

    void CompletedObjective(QuestObjective const* questObjective, Player* referencePlayer);
    bool HasCompletedObjective(QuestObjective const* questObjective) const;

protected:
    void SendCriteriaUpdate(Criteria const* entry, CriteriaProgress const* progress, uint32 timeElapsed, bool timedCompleted) const override;

    void SendCriteriaProgressRemoved(uint32 criteriaId) override;

    bool CanUpdateCriteriaTree(Criteria const* criteria, CriteriaTree const* tree, Player* referencePlayer) const override;
    bool CanCompleteCriteriaTree(CriteriaTree const* tree) override;
    void CompletedCriteriaTree(CriteriaTree const* tree, Player* referencePlayer) override;

    void SendPacket(WorldPacket const* data) const override;

    std::string GetOwnerInfo() const override;
    CriteriaList const& GetCriteriaByType(CriteriaTypes type) const override;

private:
    Player* _owner;
    std::unordered_set<uint32> _completedObjectives;
};

#endif
