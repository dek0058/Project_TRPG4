library JAPIItemState
    native EXGetItemDataString takes integer itemcode, integer data_type returns string
    native EXSetItemDataString takes integer itemcode, integer data_type, string value returns boolean

    function JNGetItemName takes item whichItem returns string
        return GetItemName(whichItem)
    endfunction

    function JNSetItemName takes item whichItem, string name returns nothing
        call EXSetItemDataString(GetItemTypeId(whichItem), 4, name)
    endfunction

    function JNSetItemDescription takes item whichItem, string description returns nothing
        call EXSetItemDataString(GetItemTypeId(whichItem), 5, description)
    endfunction

    function JNGetItemDescription takes item whichItem returns string
        return EXGetItemDataString(GetItemTypeId(whichItem), 5)
    endfunction

    function JNSetItemTooltip takes item whichItem, string tooltip returns nothing
        call EXSetItemDataString(GetItemTypeId(whichItem), 2, tooltip)
    endfunction

    function JNGetItemTooltip takes item whichItem returns string
        return EXGetItemDataString(GetItemTypeId(whichItem), 2)
    endfunction

    function JNSetItemExtendedTooltip takes item whichItem, string extendedTooltip returns nothing
        call EXSetItemDataString(GetItemTypeId(whichItem), 3, extendedTooltip)
    endfunction

    function JNGetItemExtendedTooltip takes item whichItem returns string
        return EXGetItemDataString(GetItemTypeId(whichItem), 3)
    endfunction

    function JNSetItemIconPath takes item whichItem, string iconPath returns nothing
        call EXSetItemDataString(GetItemTypeId(whichItem), 1, iconPath)
    endfunction

    function JNGetItemIconPath takes item whichItem returns string
        return EXGetItemDataString(GetItemTypeId(whichItem), 1)
    endfunction

    function JNGetItemNameById takes integer itemId returns string
        return GetObjectName(itemId)
    endfunction
    
    function JNSetItemNameById takes integer itemId, string name returns nothing
        call EXSetItemDataString(itemId, 4, name)
    endfunction
    
    function JNSetItemDescriptionById takes integer itemId, string description returns nothing
        call EXSetItemDataString(itemId, 5, description)
    endfunction
    
    function JNGetItemDescriptionById takes integer itemId returns string
        return EXGetItemDataString(itemId, 5)
    endfunction
    
    function JNSetItemTooltipById takes integer itemId, string tooltip returns nothing
        call EXSetItemDataString(itemId, 2, tooltip)
    endfunction
    
    function JNGetItemTooltipById takes integer itemId returns string
        return EXGetItemDataString(itemId, 2)
    endfunction
    
    function JNSetItemExtendedTooltipById takes integer itemId, string extendedTooltip returns nothing
        call EXSetItemDataString(itemId, 3, extendedTooltip)
    endfunction
    
    function JNGetItemExtendedTooltipById takes integer itemId returns string
        return EXGetItemDataString(itemId, 3)
    endfunction
    
    function JNSetItemIconPathById takes integer itemId, string iconPath returns nothing
        call EXSetItemDataString(itemId, 1, iconPath)
    endfunction
    
    function JNGetItemIconPathById takes integer itemId returns string
        return EXGetItemDataString(itemId, 1)
    endfunction
endlibrary