module line;


struct Line{

	private double current;
	private double end;
	private double step;

	this(double start, double end, double step = 1.0)
		in(step != 0, "Step cannot be zero"){
		this.step = step;
		this.end = end;

		// Initialize the current position to the start plus the step
		this.current = start + step; 
	}


	// 1. Range Primitive: Check if we've passed the end
	@property bool empty() const
    {
        return step > 0 ? current > end : current < end;
    }


	// 2. Range Primitive: Return the current point
	@property double front() const{
		assert(!empty, "Line is empty");
		return current;
	}

	 // 3. Range Primitive: Advance to the next interval
    void popFront()
    {
        assert(!empty, "Attempting to popFront an empty Line");
        current += step;
    }

    // Optional: Enable saving range state (ForwardRange)
    @property Line save() const
    {
        return this;
    }

	 // Operator overload for [index] access
    double opIndex(size_t index) const
    {
        double val = current + (index * step);
        assert(step > 0 ? val <= end : val >= end, "Index out of bounds");
        return val;
    }
}