/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef _ADHOCSTATEMENT_H
#define _ADHOCSTATEMENT_H

#include "Define.h"
#include "DatabaseEnvFwd.h"
#include "SQLOperation.h"

/*! Raw, ad-hoc query. */
class DATABASE_API BasicStatementTask : public SQLOperation
{
    public:
        BasicStatementTask(const char* sql, bool async = false);
        ~BasicStatementTask();

        bool Execute() override;
        QueryResultFuture GetFuture() const { return m_result->get_future(); }

    private:
        const char* m_sql;      //- Raw query to be executed
        bool m_has_result;
        QueryResultPromise* m_result;
};

#endif
