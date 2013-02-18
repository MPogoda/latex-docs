#include "convex_hull.hxx"
#include <cmath>

const double Convex_Hull::ccw(const PointF& pt1, const PointF& pt2,
                          const PointF& pt3)
{
    return (pt2.x() - pt1.x()) * (pt3.y() - pt1.y())
      - (pt2.y() - pt1.y()) * (pt3.x() - pt1.x());
}

const double Convex_Hull::dp(const PointF& pt1, const PointF& pt2)
{
    return (pt2.x() - pt1.x()) /
      std::sqrt(std::pow(pt2.x() - pt1.x(), 2)
          + std::pow(pt2.y() - pt1.y(), 2) );
}

std::vector< PointF > Convex_Hull::run(const std::vector< PointF >& m_pt)
{
    const std::size_t m_N = m_pt.size();

    PointF points[m_N + 1];
    PointF pt_temp(m_pt.front());

    for (std::size_t i( 1 ); m_N > i; ++i)
    {
        if (m_pt[i].y() < pt_temp.y())
        {
            points[i + 1] = pt_temp;
            pt_temp = m_pt[i];
        }
        else
        {
            points[i + 1] = m_pt[i];
        }
    }

    points[1] = pt_temp;

    double angle_temp(0.0);

    for (std::size_t i(2); m_N >= i; ++i)
    {
        pt_temp = points[i];
        angle_temp = dp(points[1], pt_temp);
        std::size_t k_temp( i);
        for (std::size_t j( i + 1 ); m_N >= j; ++j)
        {
            if (angle_temp < dp(points[1], points[j]))
            {
                pt_temp = points[j];
                angle_temp = dp(points[1], points[j]);
                k_temp = j;
            }
        }

        std::swap( points[k_temp], points[i] );
    }
    points[0] = points[m_N];

    std::size_t m_M( 1 );

    for (std::size_t i( 2 ); m_N >= i; ++i)
    {
        while (ccw(points[m_M - 1], points[m_M], points[i]) <= 0)
        {
            if (m_M > 1)
            {
                --m_M;
            }
            else if (m_N == i)
            {
                break;
            }
            else
            {
                ++i;
            }
        }
        ++m_M;
        std::swap(points[m_M], points[i]);
    }

    std::vector< PointF > result;

    for (std::size_t i( 0 ); m_M != i; ++i)
    {
        result.push_back(points[i+1]);
    }

    result.push_back(points[1]);

    return result;
}
