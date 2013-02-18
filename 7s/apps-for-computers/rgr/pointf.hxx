class PointF
{
    double _x;
    double _y;
public:
    const double x() const;
    const double y() const;

    void setX(const double x);
    void setY(const double y);

    PointF(const double x = 0.0,
          const double y = 0.0);
};
