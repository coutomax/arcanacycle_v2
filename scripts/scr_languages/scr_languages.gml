function load_language(_language = 0)
{
    var _archive    = "";
    
    switch (_language)
    {
        case 0:
            _archive    = "pt_br.json";
        break;
        case 1: 
            _archive    = "en_us.json";
        break;    
    }    

    var _file       = file_text_open_read(_archive);
    var _content    = "";
    
    while (true)
    {
        
        if (file_text_eof(_file)) 
        {
            break;
        }
        else
        {
            _content    += file_text_readln(_file);
        }
    }

    global.dialogue_struct    = json_parse(_content);

    file_text_close(_file);
}