module matica.line;

import std.range.primitives : isRandomAccessRange;

struct Line
{
    private double current;
    private double end;
    private double step;

    this(double start, double end, double step = 1.0)
        in (step != 0, "Step cannot be zero")
    {
        this.step = step;
        this.end = end;

        // Initialize the current position to the start plus the step
        this.current = start + step;
    }

    // 1. InputRange Primitives
    @property bool empty() const
    {
        return step > 0 ? current > end : current < end;
    }

    @property double front() const
    {
        assert(!empty, "Line is empty");
        return current;
    }

    void popFront()
    {
        assert(!empty, "Attempting to popFront an empty Line");
        current += step;
    }

    // 2. ForwardRange Primitive
    @property Line save() const
    {
        return this;
    }

    // 3. BidirectionalRange Primitives (enables foreach_reverse)
    @property double back() const
    {
        assert(!empty, "Line is empty");
        return current + ((length - 1) * step);
    }

    void popBack()
    {
        assert(!empty, "Attempting to popBack an empty Line");
        end -= step;
    }

    // 4. RandomAccessRange & Array-Like Properties
    @property size_t length() const
    {
        if (empty) return 0;
        return cast(size_t)((end - current) / step) + 1;
    }

    alias opDollar = length; // Enables '$' in myline[$ - 1] and myline[1 .. $]

    double opIndex(size_t index) const
    {
        assert(index < length, "Index out of bounds");
        return current + (index * step);
    }

    Line opSlice(size_t startIdx, size_t endIdx) const
    {
        assert(startIdx <= endIdx && endIdx <= length, "Slice indices out of bounds");
        
        // Return an empty Line if slice length is 0
        if (startIdx == endIdx)
            return Line(end, end, step);

        double newFirst = current + (startIdx * step);
        double newEnd = current + ((endIdx - 1) * step);
        
        // Subtract 'step' from newFirst because the constructor adds 'step' back
        return Line(newFirst - step, newEnd, step);
    }
}

static assert(isRandomAccessRange!Line);
