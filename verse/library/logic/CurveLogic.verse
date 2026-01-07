using { curve_logic }

# Wrapper module to satisfy legacy path references.
CurveLogic<public> := module:
    # Expose underlying curve_logic for compatibility.
    Exported := curve_logic