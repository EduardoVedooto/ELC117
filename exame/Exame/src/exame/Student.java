package exame;

public class Student {

    private String name;
    private String course;
    private String semester;
    private String registration;

    public Student(String name, String course, String semester, String registration) {
        this.name = name;
        this.course = course;
        this.semester = semester;
        this.registration = registration;
    }

    Student() {
    }

    public String getNome() {
        return name;
    }

    public void setNome(String name) {
        this.name = name;
    }

    public String getCurso() {
        return course;
    }

    public void setCurso(String course) {
        this.course = course;
    }

    public String getSemestre() {
        return semester;
    }

    public void setSemestre(String semester) {
        this.semester = semester;
    }

    public String  getMatricula() {
        return registration;
    }

    public void setMatricula(String registration) {
        this.registration = registration;
    }
    
}
