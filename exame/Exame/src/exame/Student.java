package exame;

public class Student {

    private String name;
    private String course;
    private int semester;
    private int registration;

    public Student(String name, String course, String semester, String registration) {
        this.name = name;
        this.course = course;
        this.semester = Integer.parseInt(semester);
        this.registration = Integer.parseInt(registration);
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

    public int getSemestre() {
        return semester;
    }

    public void setSemestre(int semester) {
        this.semester = semester;
    }

    public int  getMatricula() {
        return registration;
    }

    public void setMatricula(int registration) {
        this.registration = registration;
    }
    
}
