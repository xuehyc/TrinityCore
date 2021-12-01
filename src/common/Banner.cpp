/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#include "Banner.h"
#include "GitRevision.h"
#include "StringFormat.h"

void Server::Banner::Show(char const* applicationName, void(*log)(char const* text), void(*logExtraInfo)())
{
    log(" <Ctrl-C> to stop.\n");
    log(" ##     ##  #######  ########  #### ##     ##  ######      ######   #######  ########  ########");
    log(" ###   ### ##     ## ##     ##  ##  ##     ## ##    ##    ##    ## ##     ## ##     ## ##      ");
    log(" #### #### ##     ## ##     ##  ##  ##     ## ##          ##       ##     ## ##     ## ##      ");
    log(" ## ### ## ##     ## ########   ##  ##     ##  ######     ##       ##     ## ########  ######  ");
    log(" ##     ## ##     ## ##     ##  ##  ##     ##       ##    ##       ##     ## ##   ##   ##      ");
    log(" ##     ## ##     ## ##     ##  ##  ##     ## ##    ##    ##    ## ##     ## ##    ##  ##      ");
    log(" ##     ##  #######  ########  ####  #######   ######      ######   #######  ##     ## ########");
    log("                                                                          http://MobiusCore.org\n");
    if (logExtraInfo)
        logExtraInfo();
}
