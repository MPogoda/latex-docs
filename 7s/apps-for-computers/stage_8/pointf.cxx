#include "pointf.hxx"

PointF::PointF(const double x, const double y) :
  _x( x ),
  _y( y )
{
}

inline
const double PointF::x() const
{
  return _x;
}

inline
const double PointF::y() const
{
  return _y;
}

inline
void PointF::setX(const double x)
{
  _x = x;
}

inline
void PointF::setY(const double y)
{
  _y = y;
}
