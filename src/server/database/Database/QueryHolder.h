/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _QUERYHOLDER_H
#define _QUERYHOLDER_H

#include "SQLOperation.h"

class DATABASE_API SQLQueryHolderBase
{
    friend class SQLQueryHolderTask;
    private:
        std::vector<std::pair<PreparedStatementBase*, PreparedQueryResult>> m_queries;
    public:
        SQLQueryHolderBase() { }
        virtual ~SQLQueryHolderBase();
        void SetSize(size_t size);
        PreparedQueryResult GetPreparedResult(size_t index);
        void SetPreparedResult(size_t index, PreparedResultSet* result);

    protected:
        bool SetPreparedQueryImpl(size_t index, PreparedStatementBase* stmt);
};

template<typename T>
class SQLQueryHolder : public SQLQueryHolderBase
{
public:
    bool SetPreparedQuery(size_t index, PreparedStatement<T>* stmt)
    {
        return SetPreparedQueryImpl(index, stmt);
    }
};

class DATABASE_API SQLQueryHolderTask : public SQLOperation
{
    private:
        SQLQueryHolderBase* m_holder;
        QueryResultHolderPromise m_result;
        bool m_executed;

    public:
        SQLQueryHolderTask(SQLQueryHolderBase* holder)
            : m_holder(holder), m_executed(false) { }

        ~SQLQueryHolderTask();

        bool Execute() override;
        QueryResultHolderFuture GetFuture() { return m_result.get_future(); }
};

#endif
