module matica.shape;

import std.math;


interface Shape{
    @property string name()const;
    @property string type()const;
}

abstract class Shape2D :Shape{
    abstract double area() const;
    abstract double perimeter() const;

    // Default implementation of Shape.describe() for all 2D shapes
    string type() const{
        import std.format: format;
        return format("Shape: %s, Type: %s, Area: %s, Perimeter: %s", name, type, area(), perimeter());
    }
}

abstract class Shape3D :Shape{
    abstract double volume() const;
    abstract double surfaceArea() const;

    // Default implementation of Shape.describe() for all 3D shapes
    string type() const{
        import std.format: format;
        return format("Shape: %s, Type: %s, Volume: %s, Surface Area: %s", name, type, volume(), surfaceArea());
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
