/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef METRIC_H__
#define METRIC_H__

#include "Define.h"
#include "MPSCQueue.h"
#include <chrono>
#include <functional>
#include <iosfwd>
#include <memory>
#include <string>

namespace Server
{
    namespace Asio
    {
        class IoContext;
        class DeadlineTimer;
    }
}

enum MetricDataType
{
    METRIC_DATA_VALUE,
    METRIC_DATA_EVENT
};

struct MetricData
{
    std::string Category;
    std::chrono::system_clock::time_point Timestamp;
    MetricDataType Type;

    // LogValue-specific fields
    std::string Value;

    // LogEvent-specific fields
    std::string Title;
    std::string Text;
};

class COMMON_API Metric
{
private:
    std::iostream& GetDataStream() { return *_dataStream; }
    std::unique_ptr<std::iostream> _dataStream;
    MPSCQueue<MetricData> _queuedData;
    std::unique_ptr<Server::Asio::DeadlineTimer> _batchTimer;
    std::unique_ptr<Server::Asio::DeadlineTimer> _overallStatusTimer;
    int32 _updateInterval = 0;
    int32 _overallStatusTimerInterval = 0;
    bool _enabled = false;
    bool _overallStatusTimerTriggered = false;
    std::string _hostname;
    std::string _port;
    std::string _databaseName;
    std::function<void()> _overallStatusLogger;
    std::string _realmName;

    bool Connect();
    void SendBatch();
    void ScheduleSend();
    void ScheduleOverallStatusLog();

    static std::string FormatInfluxDBValue(bool value);
    template<class T>
    static std::string FormatInfluxDBValue(T value);
    static std::string FormatInfluxDBValue(std::string const& value);
    static std::string FormatInfluxDBValue(const char* value);
    static std::string FormatInfluxDBValue(double value);
    static std::string FormatInfluxDBValue(float value);

    static std::string FormatInfluxDBTagValue(std::string const& value);

    // ToDo: should format TagKey and FieldKey too in the same way as TagValue

public:
    Metric();
    ~Metric();
    static Metric* instance();

    void Initialize(std::string const& realmName, Server::Asio::IoContext& ioContext, std::function<void()> overallStatusLogger);
    void LoadFromConfigs();
    void Update();

    template<class T>
    void LogValue(std::string const& category, T value)
    {
        using namespace std::chrono;

        MetricData* data = new MetricData;
        data->Category = category;
        data->Timestamp = system_clock::now();
        data->Type = METRIC_DATA_VALUE;
        data->Value = FormatInfluxDBValue(value);

        _queuedData.Enqueue(data);
    }

    void LogEvent(std::string const& category, std::string const& title, std::string const& description);

    void ForceSend();
    bool IsEnabled() const { return _enabled; }
};

#define sMetric Metric::instance()

#if SERVER_PLATFORM != SERVER_PLATFORM_WINDOWS
#define METRIC_EVENT(category, title, description)                    \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogEvent(category, title, description);   \
        } while (0)
#define METRIC_VALUE(category, value)                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogValue(category, value);                \
        } while (0)
#else
#define METRIC_EVENT(category, title, description)                    \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogEvent(category, title, description);   \
        } while (0)                                                     \
        __pragma(warning(pop))
#define METRIC_VALUE(category, value)                                 \
        __pragma(warning(push))                                         \
        __pragma(warning(disable:4127))                                 \
        do {                                                            \
            if (sMetric->IsEnabled())                              \
                sMetric->LogValue(category, value);                \
        } while (0)                                                     \
        __pragma(warning(pop))
#endif

#endif // METRIC_H__
