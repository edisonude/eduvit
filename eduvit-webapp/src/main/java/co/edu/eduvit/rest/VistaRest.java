package co.edu.eduvit.rest;
 
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.util.UriComponentsBuilder;

import co.edu.eduvit.entities.Vista;
import co.edu.eduvit.service.VistaService;
 
@RestController
@RequestMapping("/vista")
public class VistaRest {
	
	@Autowired
	private VistaService vistaService;

	/**
	 * Servicio para obtener la lista con todas las vistas
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET, produces="application/json; charset=UTF-8")
	public ResponseEntity<List<Vista>> list() {
		List<Vista> listVista = vistaService.listAll();
		if(listVista.isEmpty()){
            return new ResponseEntity<List<Vista>>(HttpStatus.NO_CONTENT);
        }
        return new ResponseEntity<List<Vista>>(listVista, HttpStatus.OK);
	}
	
	/** 
	 * Servicio para encontrar una vista por su id
	 * @param id id a buscar
	 * @return
	 */
	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    public ResponseEntity<Vista> findById(@PathVariable("id") Integer id) {
        Vista vista = vistaService.findById(id); 
        if (vista == null) {
            System.out.println("Vista with id " + id + " not found");
            return new ResponseEntity<Vista>(HttpStatus.NOT_FOUND);
        }
        return new ResponseEntity<Vista>(vista, HttpStatus.OK);
    }
	
	/**
	 * Servicio para crear un nuevo registro de vista
	 * 
	 * @param vista
	 * @param ucBuilder
	 * @return
	 */
//	@RequestMapping(value = "/add/", method = RequestMethod.POST)
//    public ResponseEntity<Void> add(@RequestBody Vista vista, UriComponentsBuilder ucBuilder) {
//        vistaService.insert(vista);
// 
//        HttpHeaders headers = new HttpHeaders();
//        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(vista.getIdRecurso()).toUri());
//        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
//    }
	
	/**
	 * Servicio para crear un nuevo registro de vista
	 * 
	 * @param descripcion descripcion de la vista
	 * @param url url de la vista
	 * @param ucBuilder
	 * @return
	 */
	@RequestMapping(value = "/add/{descripcion}/{url}", method = RequestMethod.POST)
    public ResponseEntity<Void> add(@PathVariable("descripcion") String descripcion,@PathVariable("url") String url, UriComponentsBuilder ucBuilder) {
		
		Vista vista = new Vista(descripcion, url);
        vistaService.insert(vista);
 
        HttpHeaders headers = new HttpHeaders();
        headers.setLocation(ucBuilder.path("/{id}").buildAndExpand(vista.getIdRecurso()).toUri());
        return new ResponseEntity<Void>(headers, HttpStatus.CREATED);
    }
	
	/**
	 * Servicio para eliminar una vista
	 * 
	 * @param id identificacion de la vista a eliminar
	 * @return
	 */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.DELETE)
    public ResponseEntity<Vista> deleteUser(@PathVariable("id") Integer id) {
        Vista vista = vistaService.findById(id);
        if (vista == null) {
            return new ResponseEntity<Vista>(HttpStatus.NOT_FOUND);
        }
        vistaService.delete(id);
        return new ResponseEntity<Vista>(HttpStatus.OK);
    }
}