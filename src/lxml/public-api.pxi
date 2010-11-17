# Public C API for lxml.etree

cdef public api _Element deepcopyNodeToDocument(_Document doc, xmlNode* c_root):
    u"Recursively copy the element into the document. doc is not modified."
    cdef xmlNode* c_node
    c_node = _copyNodeToDoc(c_root, doc._c_doc)
    return _elementFactory(doc, c_node)

cdef public api _ElementTree elementTreeFactory(_Element context_node):
    return newElementTree(context_node, _ElementTree)

cdef public api _ElementTree newElementTree(_Element context_node,
                                        object subclass):
    if <void*>context_node is NULL or context_node is None:
        raise TypeError

    return _newElementTree(context_node._doc, context_node, subclass)

cdef public api _Element elementFactory(_Document doc, xmlNode* c_node):
    if c_node is NULL or doc is None:
        raise TypeError
    return _elementFactory(doc, c_node)

cdef public api _Element makeElement(tag, _Document doc, parser,
                                 text, tail, attrib, nsmap):
    return _makeElement(tag, NULL, doc, parser, text, tail, attrib, nsmap, None)

cdef public api _Element makeSubElement(_Element parent, tag, text, tail,
                                    attrib, nsmap):
    return _makeSubElement(parent, tag, text, tail, attrib, nsmap, None)

cdef public api void setElementClassLookupFunction(
    _element_class_lookup_function function, state):
    _setElementClassLookupFunction(function, state)

cdef public api object lookupDefaultElementClass(state, doc, xmlNode* c_node):
    return _lookupDefaultElementClass(state, doc, c_node)

cdef public api object lookupNamespaceElementClass(state, doc, xmlNode* c_node):
    return _find_nselement_class(state, doc, c_node)

cdef public api object callLookupFallback(FallbackElementClassLookup lookup,
                                      _Document doc, xmlNode* c_node):
    return _callLookupFallback(lookup, doc, c_node)

cdef public api int tagMatches(xmlNode* c_node, char* c_href, char* c_name):
    if c_node is NULL:
        return -1
    return _tagMatches(c_node, c_href, c_name)

cdef public api _Document documentOrRaise(object input):
    return _documentOrRaise(input)

cdef public api _Element rootNodeOrRaise(object input):
    return _rootNodeOrRaise(input)

cdef public api bint hasText(xmlNode* c_node):
    return _hasText(c_node)

cdef public api bint hasTail(xmlNode* c_node):
    return _hasTail(c_node)

cdef public api object textOf(xmlNode* c_node):
    if c_node is NULL:
        return None
    return _collectText(c_node.children)

cdef public api object tailOf(xmlNode* c_node):
    if c_node is NULL:
        return None
    return _collectText(c_node.next)

cdef public api int setNodeText(xmlNode* c_node, text) except -1:
    if c_node is NULL:
        raise ValueError
    return _setNodeText(c_node, text)

cdef public api int setTailText(xmlNode* c_node, text) except -1:
    if c_node is NULL:
        raise ValueError
    return _setTailText(c_node, text)

cdef public api object attributeValue(xmlNode* c_element, xmlAttr* c_attrib_node):
    return _attributeValue(c_element, c_attrib_node)

cdef public api object attributeValueFromNsName(xmlNode* c_element,
                                            char* ns, char* name):
    return _attributeValueFromNsName(c_element, ns, name)

cdef public api object getAttributeValue(_Element element, key, default):
    return _getAttributeValue(element, key, default)

cdef public api object iterattributes(_Element element, int keysvalues):
    return _attributeIteratorFactory(element, keysvalues)

cdef public api list collectAttributes(xmlNode* c_element, int keysvalues):
    return _collectAttributes(c_element, keysvalues)

cdef public api int setAttributeValue(_Element element, key, value) except -1:
    return _setAttributeValue(element, key, value)

cdef public api int delAttribute(_Element element, key) except -1:
    return _delAttribute(element, key)

cdef public api int delAttributeFromNsName(tree.xmlNode* c_element,
                                       char* c_href, char* c_name):
    return _delAttributeFromNsName(c_element, c_href, c_name)

cdef public api bint hasChild(xmlNode* c_node):
    return _hasChild(c_node)

cdef public api xmlNode* findChild(xmlNode* c_node, Py_ssize_t index):
    return _findChild(c_node, index)

cdef public api xmlNode* findChildForwards(xmlNode* c_node, Py_ssize_t index):
    return _findChildForwards(c_node, index)

cdef public api xmlNode* findChildBackwards(xmlNode* c_node, Py_ssize_t index):
    return _findChildBackwards(c_node, index)

cdef public api xmlNode* nextElement(xmlNode* c_node):
    return _nextElement(c_node)

cdef public api xmlNode* previousElement(xmlNode* c_node):
    return _previousElement(c_node)

cdef public api void appendChild(_Element parent, _Element child):
    _appendChild(parent, child)

cdef public api object pyunicode(char* s):
    if s is NULL:
        raise TypeError
    return funicode(s)

cdef public api bytes utf8(object s):
    return _utf8(s)

cdef public api tuple getNsTag(object tag):
    return _getNsTag(tag)

cdef public api object namespacedName(xmlNode* c_node):
    return _namespacedName(c_node)

cdef public api object namespacedNameFromNsName(char* href, char* name):
    return _namespacedNameFromNsName(href, name)

cdef public api void iteratorStoreNext(_ElementIterator iterator, _Element node):
    iterator._storeNext(node)

cdef public api void initTagMatch(_ElementTagMatcher matcher, tag):
    matcher._initTagMatch(tag)

cdef public api tree.xmlNs* findOrBuildNodeNsPrefix(
    _Document doc, xmlNode* c_node, char* href, char* prefix) except NULL:
    if doc is None:
        raise TypeError
    return doc._findOrBuildNodeNs(c_node, href, prefix, 0)
