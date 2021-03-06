package harbor

import org.springframework.dao.DataIntegrityViolationException

class StateController {

    static allowedMethods = [save: "POST", update: "POST", delete: ["POST","GET"]]

    def index() {
        if(session.user && session.user.permissions.contains("admin")) {
			redirect(action: "list", params: params)
		}
    }

    def list(Integer max) {
		if(session.user && session.user.permissions.contains("admin")) {
	        params.max = Math.min(max ?: 10, 100)
	        [stateInstanceList: State.list(params), stateInstanceTotal: State.count()]
		}
    }

    def create() {
		if(session.user && session.user.permissions.contains("admin")) {
			[stateInstance: new State(params)]
		}
    }

    def save() {
		if(session.user && session.user.permissions.contains("admin")) {
	        def stateInstance = new State(params)
	        if (!stateInstance.save(flush: true)) {
	            render(view: "create", model: [stateInstance: stateInstance])
	            return
	        }
	
	        flash.message = message(code: 'default.created.message', args: [message(code: 'state.label', default: 'State'), stateInstance.id])
	        redirect(action: "show", id: stateInstance.id)
		}
    }

    def show(Long id) {
        def stateInstance = State.get(id)
        if (!stateInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'state.label', default: 'State'), id])
            redirect(action: "list")
            return
        }

        [stateInstance: stateInstance]
    }

    def edit(Long id) {
		if(session.user && session.user.permissions.contains("admin")) {
	        def stateInstance = State.get(id)
	        if (!stateInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'state.label', default: 'State'), id])
	            redirect(action: "list")
	            return
	        }
	
	        [stateInstance: stateInstance]
		}
    }

    def update(Long id, Long version) {
		if(session.user && session.user.permissions.contains("admin")) {
	        def stateInstance = State.get(id)
	        if (!stateInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'state.label', default: 'State'), id])
	            redirect(action: "list")
	            return
	        }
	
	        if (version != null) {
	            if (stateInstance.version > version) {
	                stateInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
	                          [message(code: 'state.label', default: 'State')] as Object[],
	                          "Another user has updated this State while you were editing")
	                render(view: "edit", model: [stateInstance: stateInstance])
	                return
	            }
	        }
	
	        stateInstance.properties = params
	
	        if (!stateInstance.save(flush: true)) {
	            render(view: "edit", model: [stateInstance: stateInstance])
	            return
	        }
	
	        flash.message = message(code: 'default.updated.message', args: [message(code: 'state.label', default: 'State'), stateInstance.id])
	        redirect(action: "show", id: stateInstance.id)
		}
    }

    def delete(Long id) {
		if(session.user && session.user.permissions.contains("admin")) {
	        def stateInstance = State.get(id)
			def assetsByState = Asset.getAssetsByState(stateInstance, 25);
			if(assetsByState.size() != 0) {
				flash.message = "Unable to remove state. It is currently in use."
				redirect(controller:"state", action:"list")
			} else {
		        if (!stateInstance) {
		            flash.message = message(code: 'default.not.found.message', args: [message(code: 'state.label', default: 'State'), stateInstance])
		            redirect(action: "list")
		            return
		        }
		
		        try {
		            stateInstance.delete(flush: true)
		            flash.message = message(code: 'default.deleted.message', args: [message(code: 'state.label', default: 'State'), stateInstance])
		            redirect(action: "list")
		        }
		        catch (DataIntegrityViolationException e) {
		            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'state.label', default: 'State'), stateInstance])
		            redirect(action: "show", id: id)
		        }
			}
		}
    }
}
