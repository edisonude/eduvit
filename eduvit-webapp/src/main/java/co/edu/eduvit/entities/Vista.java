package co.edu.eduvit.entities;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "vista", catalog = "bd_eduvit")
public class Vista implements java.io.Serializable {

	private static final long serialVersionUID = 3543336809533934852L;
	
	private Integer idRecurso;
	private String descripcion;
	private String url;

	public Vista() {
	}

	public Vista(String descripcion, String url) {
		this.descripcion = descripcion;
		this.url = url;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "id_recurso", unique = true, nullable = false)
	public Integer getIdRecurso() {
		return this.idRecurso;
	}

	public void setIdRecurso(Integer idRecurso) {
		this.idRecurso = idRecurso;
	}

	@Column(name = "descripcion", nullable = false, length = 50)
	public String getDescripcion() {
		return this.descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	@Column(name = "url", nullable = false, length = 100)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
