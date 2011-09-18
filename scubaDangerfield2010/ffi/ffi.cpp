#include <cadence/cadence.h>
#include <iostream>
#include "dll.h"
#include <cadence/dstring.h>
#include <cadence/doste/handler.h>
#include <cadence/doste/event.h>
#include <cmath>

using namespace cadence;
using namespace cadence::doste;

// the <*:9001:*:*> range is used for FFI functions (and partially applied functions)
// 
const OID ffi_base = OID(0,9001,0,0);
const OID ffi_lower = ffi_base;
const OID ffi_higher = ffi_base + OID(0,4,0,0);

class FFIHandler : Handler {
public:
	FFIHandler(const OID &oid);
	bool handle(Event &event);
private:
	OID m_base;
	const OID Pow;
	const OID PartialPow;
};

FFIHandler::FFIHandler(const OID &oid) : 
	Handler(ffi_lower, ffi_higher), 
	m_base(oid), 
	Pow(m_base + OID(0,1,0,0)),
	PartialPow(Pow + OID(0,1,0,0)) {}

bool FFIHandler::handle(Event &event) {
	// currently this uses an insane method for determining what OID to return
	// this is totally unextensible and will be replaced with a generic system ASAP
	if (event.type() == Event::GET) {

		if (event.dest() == m_base) {
			// if we're looking up pow
			if (event.param<0>() == OID("pow")) {
				event.result(Pow);
			} else {
				event.result(Null);
			}
		} else if (event.dest() == Pow) {
			// else if we're looking up partially applied pow
			// if we're looking up an integer, convert it to a double
			if (event.param<0>().isLongLong()) {
				OID temp = PartialPow;
				temp.m_dbl = (double)event.param<0>().m_ll;
				event.result(temp);
			} else if (event.param<0>().isDouble()) {
				OID temp = Pow + OID(0,1,0,0);
				temp.m_dbl = event.param<0>().m_dbl;
				event.result(temp);
			} else {
				event.result(Null);
			}
		} else if (event.dest().b() == PartialPow.b()) {
			// else we're looking up fully applied pow
			if (event.param<0>().isLongLong()) {
				event.result(std::pow(event.dest().m_dbl, (double)event.param<0>().m_ll));
			} else if (event.param<0>().isDouble()) {
				event.result(std::pow(event.dest().m_dbl, event.param<0>().m_dbl));
			} else {
				event.result(Null);
			}
		}
	}
	return true;
}

FFIHandler *ffi_handler = NULL;

extern "C" void FFIIMPORT initialise(const cadence::doste::OID &base) {
	base["ffi"] = ffi_base;
	ffi_handler = new FFIHandler(ffi_base);
}

extern "C" void FFIIMPORT finalise() {
	if (ffi_handler != NULL)
		delete ffi_handler;
}
