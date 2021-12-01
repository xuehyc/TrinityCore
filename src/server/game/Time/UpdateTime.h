/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef __UPDATETIME_H
#define __UPDATETIME_H

#include "Define.h"
#include <array>
#include <string>

#define AVG_DIFF_COUNT 500

class GAME_API UpdateTime
{
    using DiffTableArray = std::array<uint32, AVG_DIFF_COUNT>;

    public:
        uint32 GetAverageUpdateTime() const;
        uint32 GetTimeWeightedAverageUpdateTime() const;
        uint32 GetMaxUpdateTime() const;
        uint32 GetMaxUpdateTimeOfCurrentTable() const;
        uint32 GetLastUpdateTime() const;

        void UpdateWithDiff(uint32 diff);

        void RecordUpdateTimeReset();

    protected:
        UpdateTime();

        void _RecordUpdateTimeDuration(std::string const& text, uint32 minUpdateTime);

    private:
        DiffTableArray _updateTimeDataTable;
        uint32 _averageUpdateTime;
        uint32 _totalUpdateTime;
        uint32 _updateTimeTableIndex;
        uint32 _maxUpdateTime;
        uint32 _maxUpdateTimeOfLastTable;
        uint32 _maxUpdateTimeOfCurrentTable;

        uint32 _recordedTime;
};

class GAME_API WorldUpdateTime : public UpdateTime
{
    public:
        WorldUpdateTime() : UpdateTime(), _recordUpdateTimeInverval(0), _recordUpdateTimeMin(0), _lastRecordTime(0) { }
        void LoadFromConfig();
        void SetRecordUpdateTimeInterval(uint32 t);
        void RecordUpdateTime(uint32 gameTimeMs, uint32 diff, uint32 sessionCount);
        void RecordUpdateTimeDuration(std::string const& text);

    private:
        uint32 _recordUpdateTimeInverval;
        uint32 _recordUpdateTimeMin;
        uint32 _lastRecordTime;
};

GAME_API extern WorldUpdateTime sWorldUpdateTime;

#endif
