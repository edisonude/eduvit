package co.edu.eduvit.dao;

import java.util.List;

import co.edu.eduvit.entities.Vista;

/**
 * Interface del DAO para el control de las Vistas de la aplicación
 * @author Edison
 *
 */
public interface VistaDAO {

	/**
	 * Crea un nuevo registro de vista
	 * @param vista vista a crear
	 */
	public void insert(Vista vista);
	
	/**
	 * Actualiza un registro existente de una vista
	 * @param vista vista a actualizar
	 */
	public void update(Vista vista);
	
	/**
	 * Encuentra todas las vistas de la aplicación
	 * @return
	 */
	public List<Vista> listAll();
	
	/**
	 * Encuentra una vista por su id
	 * @param id identificación de la vista que se espera encontrar
	 * @return
	 */
	public Vista findById(Integer id);
	
	/**
	 * Elimina una vista existente
	 * @param id identificación de la vista que se quiere eliminar
	 */
	public void delete(Integer id);
}
