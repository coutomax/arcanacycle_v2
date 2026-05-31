function state_machine (_initial_state = undefined) constructor
{
    state           = undefined; //the current state of the state machine
    previous_state  = undefined; //the previous state of the state machine
    initial_state   = _initial_state; //the initial state of the state machine, if is undefined, the state machine will start without a state
    states          = []; // array of states 
    state_ids       = {}; // array of state ids, "idle" : 0, "walk" : 1, etc
    transitions     = {}; //"idle" : {destinations: {"name" : function}}, "walk" : {destinations: {"name" : function}} etc
    state_id        = 0; //state_id is used to give an unique id to each state, so we can identify them later
    instance        = undefined;
    parent_run      = undefined; //parent_run is a function that will run in every state. if is undefined, it will be an empty and doesn't need to be executed in every state.
    
    #region private methods
    static _enter   = function ()
    {
        gml_pragma("forceinline");
        var _state = states[state];
		
        if (_state.on_enter != undefined)
        {
            method(instance, _state.on_enter) ();
        }
    }

    static _step        = function ()
    {
        gml_pragma("forceinline");
        var _state = states[state];
		
        if (_state.on_step != undefined)
        {
            method(instance, _state.on_step) ();
        }
    }

    static _exit        = function ()
    {
        gml_pragma("forceinline");
        var _state      = states[state];
		
        if (_state.on_exit != undefined)
        {
            method(instance, _state.on_exit) ();
        }
    }

    static set_state   = function (_state)
    {
        if (is_string(_state))
        {
            _state      = state_ids[$ _state];
        }

        if (state == _state)
        {
            return;
        }

        previous_state  = state;
		
		_exit();
		
		state           = _state;
        
		_enter();		
    }
    #endregion

    #region public methods
    static add_state    = function (_name, _struct = undefined)
    {
        states[state_id]                = _struct;
        states[state_id][$ "name"]      = _name;
        states[state_id][$ "on_enter"]  ??= undefined;
        states[state_id][$ "on_step"]   ??= undefined;
        states[state_id][$ "on_exit"]   ??= undefined;
        state_ids[$ _name]              = state_id;
        state_id++;
        return self;
    }

    static update       = function (_instance)
    {
        instance        = _instance;

        if (initial_state != undefined)
        {
            if  (is_string(initial_state))
            {
                initial_state   = state_ids[$ initial_state];
            }

            if (initial_state >= 0)
            {
                state           = initial_state;
                previous_state  = state;

                var _new_state  = states[initial_state];

                if(_new_state.on_enter != undefined)
                {
                    method(instance, _new_state.on_enter) ();
                }
            }
            initial_state       = undefined;
        }

        if (parent_run != undefined) 
        {
            parent_run();
        } 

        if (state == undefined)
        {
            return;
        }
         
        var _current_state      = states[state];

        if (_current_state.on_step != undefined)
        {
            method(instance, _current_state.on_step) ();
        }

        var _transitions        = transitions[$ _current_state.name];

        if (_transitions != undefined)
        {
            var _destinations   = _transitions.destinations;
            var _names          = variable_struct_get_names(_destinations);
            var i               = 0;
            var i_size          = array_length(_names);
            var name            = "";

            repeat (i_size)
            {
                name        = _names[i];

                if (method(instance, _destinations[$ name]) ())
                {
                    set_state(name);
                    break;
                }
                i++;
            }
        }
    }

    static get_state        = function ()
    {
        return states[state].name;
    }

    static add_transition   = function (_from_state, _destination, _condition)
    {
        if (!variable_struct_exists(transitions, _from_state))
        {
            transitions[$ _from_state]      = {
                destinations: {}
            };
        }
        transitions[$ _from_state].destinations[$ _destination] = _condition;
        return self;
    }
    #endregion
}