#include "status.h"

using namespace domain;

Status::Status(bool armed, bool online, const QString& modeString):
    m_armed(armed),
    m_online(online),
    m_modeString(modeString)
{}

bool Status::armed() const
{
    return m_armed;
}

void Status::setArmed(bool armed)
{
    m_armed = armed;
}

bool Status::online() const
{
    return m_online;
}

void Status::setOnline(bool online)
{
    m_online = online;
}

QString Status::modeString() const
{
    return m_modeString;
}

void Status::setModeString(const QString& modeString)
{
    m_modeString = modeString;
}

bool Status::operator ==(const Status& other)
{
    return m_armed == other.armed() &&
            m_online == other.online() &&
            m_modeString == other.modeString();
}
