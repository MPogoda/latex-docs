#include "pointf.hxx"
#include <vector>

class Convex_Hull
{
    static const double ccw(const PointF& pt1, const PointF& pt2,
                            const PointF& pt3);
    static const double dp(const PointF& pt1, const PointF& pt2);
public:
    static std::vector< PointF > run( const std::vector< PointF >& m_pt);
};
