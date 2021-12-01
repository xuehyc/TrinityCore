/**
 * This file is part of the MobiusCore project.
 * See AUTHORS file for copyright information.
 */

#ifndef CinematicMgr_h__
#define CinematicMgr_h__

#include "Define.h"
#include "Object.h"

#define CINEMATIC_LOOKAHEAD (2 * IN_MILLISECONDS)
#define CINEMATIC_UPDATEDIFF 500

class Player;
struct CinematicSequencesEntry;
struct FlyByCamera;

class GAME_API CinematicMgr
{
    friend class Player;
public:
    explicit CinematicMgr(Player* playerref);
    ~CinematicMgr();
    // Cinematic camera data and remote sight functions
    bool IsOnCinematic() const { return (m_cinematicCamera != nullptr); }
    void BeginCinematic(CinematicSequencesEntry const* cinematic)
    {
        m_activeCinematic = cinematic;
        m_activeCinematicCameraIndex = -1;
    }
    void NextCinematicCamera();
    void EndCinematic();
    void UpdateCinematicLocation(uint32 diff);

private:
    // Remote location information
    Player*     player;

protected:
    uint32      m_cinematicDiff;
    uint32      m_lastCinematicCheck;
    CinematicSequencesEntry const* m_activeCinematic;
     int32      m_activeCinematicCameraIndex;
    uint32      m_cinematicLength;
    std::vector<FlyByCamera> const* m_cinematicCamera;
    Position    m_remoteSightPosition;
    TempSummon* m_CinematicObject;
};

#endif // CinematicMgr_h__
