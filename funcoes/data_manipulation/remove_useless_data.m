function data = remove_useless_data(P, data)
    if ~P.has_h()
        data.h = [];
        data.traceback.h = [];
    end
    if ~P.has_g()
        data.g = [];
        data.traceback.g = [];
    end
end

