/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef AsyncCallbackProcessor_h__
#define AsyncCallbackProcessor_h__

#include "Define.h"
#include <algorithm>
#include <vector>

//template <class T>
//concept AsyncCallback = requires(T t) { { t.InvokeIfReady() } -> std::convertible_to<bool> };

template<typename T> // requires AsyncCallback<T>
class AsyncCallbackProcessor
{
public:
    AsyncCallbackProcessor() = default;
    ~AsyncCallbackProcessor() = default;

    T& AddCallback(T&& query)
    {
        _callbacks.emplace_back(std::move(query));
        return _callbacks.back();
    }

    void ProcessReadyCallbacks()
    {
        if (_callbacks.empty())
            return;

        std::vector<T> updateCallbacks{ std::move(_callbacks) };

        updateCallbacks.erase(std::remove_if(updateCallbacks.begin(), updateCallbacks.end(), [](T& callback)
        {
            return callback.InvokeIfReady();
        }), updateCallbacks.end());

        _callbacks.insert(_callbacks.end(), std::make_move_iterator(updateCallbacks.begin()), std::make_move_iterator(updateCallbacks.end()));
    }

private:
    AsyncCallbackProcessor(AsyncCallbackProcessor const&) = delete;
    AsyncCallbackProcessor& operator=(AsyncCallbackProcessor const&) = delete;

    std::vector<T> _callbacks;
};

#endif // AsyncCallbackProcessor_h__
