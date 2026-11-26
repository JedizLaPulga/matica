module matica.shape;

import std.math;    


interface Shape{
    @property string name()const;
    @property string type()const;
}

abstract class Shape2D :Shape{
    abstract double area() const;
    abstract double perimeter() const;
    enum int shapeType = 2;

    // Default implementation of Shape.describe() for all 2D shapes
    string type() const{
        import std.format: format;
        return format("Shape: %s, Type: %dD, Area: %.2f, Perimeter: %.2f",
            name, shapeType, area(), perimeter());

    }
}

abstract class Shape3D :Shape{
    abstract double volume() const;
    abstract double surfaceArea() const;
    enum int shapeType = 3;

    // Default implementation of Shape.describe() for all 3D shapes
    string type() const{
        import std.format: format;
        return format("Shape: %s, Type: %dD, Volume: %.2f, Surface Area: %.2f", 
        name, shapeType, volume(), surfaceArea());
    }
}

//////////////////////////////////////////////////
// Optional trait interface for shapes with diagonals
interface HasDiagonal
{
    double diagonal() const;
}

// 4. Concrete Implementations
class Rectangle : Shape2D, HasDiagonal
{
    private double _length;
    private double _width;

    this(double length, double width)
        in (length > 0 && width > 0, "Dimensions must be positive")
    {
        _length = length;
        _width = width;
    }

    @property string name() const { return "Rectangle"; }
    @property double length() const { return _length; }
    @property double width() const { return _width; }

    override double area() const { return _length * _width; }
    override double perimeter() const { return 2 * (_length + _width); }
    double diagonal() const { return hypot(_length, _width); }
}

class Sphere : Shape3D
{
    private double _radius;

    this(double radius)
        in (radius > 0, "Radius must be positive")
    {
        _radius = radius;
    }

    @property string name() const { return "Sphere"; }
    @property double radius() const { return _radius; }

    override double volume() const { return (4.0 / 3.0) * PI * (_radius ^^ 3); }
    override double surfaceArea() const { return 4.0 * PI * (_radius ^^ 2); }
}

class Triangle : Shape2D
{
    private double _a;
    private double _b;
    private double _c;

    this(double a, double b, double c)
        in (a > 0 && b > 0 && c > 0, "Side lengths must be positive")
        in (a + b > c && a + c > b && b + c > a, "Invalid triangle: violates triangle inequality")
    {
        _a = a;
        _b = b;
        _c = c;
    }

    @property double a() const { return _a; }
    @property double b() const { return _b; }
    @property double c() const { return _c; }

    @property string name() const
    {
       enum eps = 1e-9;
        bool ab = abs(_a - _b) < eps;
        bool bc = abs(_b - _c) < eps;
        bool ac = abs(_a - _c) < eps;

        if (ab && bc)
            return "Equilateral Triangle";
        else if (ab || bc || ac)
            return "Isosceles Triangle";
        else
            return "Scalene Triangle";
    }

    override double perimeter() const
    {
        return _a + _b + _c;
    }

    override double area() const
    {
        // Heron's formula
        double s = perimeter() / 2.0;
        return sqrt(s * (s - _a) * (s - _b) * (s - _c));
    }
}
