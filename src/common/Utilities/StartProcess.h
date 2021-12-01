/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef Process_h__
#define Process_h__

#include "Define.h"
#include <future>
#include <memory>
#include <vector>
#include <string>

namespace Server
{

/// Starts a process with the given arguments and parameters and will block
/// until the process is finished.
/// When an input path is given, the file will be routed to the processes stdin.
/// When the process is marked as secure no arguments are leaked to logs.
/// Note that most executables expect it's name as the first argument.
COMMON_API int StartProcess(std::string const& executable, std::vector<std::string> const& args,
                               std::string const& logger, std::string input_file = "",
                               bool secure = false);

/// Platform and library independent representation
/// of asynchronous process results
class AsyncProcessResult
{
public:
    virtual ~AsyncProcessResult() { }

    /// Returns the future which contains the result of the process
    /// as soon it is finished.
    virtual std::future<int>& GetFutureResult() = 0;

    /// Tries to terminate the process
    virtual void Terminate() = 0;
};

/// Starts a process asynchronously with the given arguments and parameters and
/// returns an AsyncProcessResult immediately which is set, when the process exits.
/// When an input path is given, the file will be routed to the processes stdin.
/// When the process is marked as secure no arguments are leaked to logs.
/// Note that most executables expect it's name as the first argument.
COMMON_API std::shared_ptr<AsyncProcessResult>
    StartAsyncProcess(std::string executable, std::vector<std::string> args,
                      std::string logger, std::string input_file = "",
                      bool secure = false);

/// Searches for the given executable in the PATH variable
/// and returns a present optional when it was found.
COMMON_API std::string SearchExecutableInPath(std::string const& filename);

} // namespace Server

#endif // Process_h__
